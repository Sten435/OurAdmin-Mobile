import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';

import '../../custom_widgets/custom_list_view_card.dart';
import '../../domein/column.dart';
import '../../domein/database.dart';
import '../../domein/table.dart';
import '../../manager/structuur_manager.dart';
import '../alert_popups/error_popups.dart';

class StructuurView extends StatefulWidget {
  const StructuurView({super.key});

  @override
  State<StructuurView> createState() => _StructuurViewState();
}

class _StructuurViewState extends State<StructuurView> {
  final typeNames = List<String>.generate(10, (i) => "Type: ${i + 1}");
  int? selectedIndex;
  late List<DBColumn> columns;

  @override
  Widget build(BuildContext context) {
    final DatabaseState databaseState = context.read<DatabaseBloc>().state;
    final Database? selectedDatabase = databaseState.selectedDatabase;
    final DBTable? selectedTable = databaseState.selectedTable;

    if (selectedDatabase == null) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('No Database Selected', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () => GoRouter.of(context).go('/'), child: const Text("Select Database")),
      ]));
    }

    if (selectedTable == null) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('No Table Selected', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () => GoRouter.of(context).go('/tables'), child: const Text("Select Table")),
      ]));
    }

    columns = selectedTable.columns;

    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: columns.length,
            itemBuilder: (context, index) {
              var column = columns[index];
              return GestureDetector(
                child: CustomListViewCard(
                  leading: column.name,
                  tailingIcon: const Icon(Icons.delete_forever),
                  leadingClick: () => deleteDialog(selectedTable, column),
                  subLeading: "${column.type},${column.keyType?.name ?? ""},${column.isNullable == true ? "null" : ""}".split(",").where((s) => s.isNotEmpty).join(" - "),
                  selected: selectedIndex == index,
                ),
                onTap: () {
                  setState(() {
                    if (selectedIndex == index) {
                      selectedIndex = null;
                    } else {
                      selectedIndex = index;
                    }
                  });
                },
              );
            },
          ),
        ),
        if (selectedIndex != null) footerButtons(selectedTable),
      ],
    );
  }

  Widget footerButtons(DBTable table) {
    return Column(
      children: [
        const Divider(color: Colors.brown, height: 0, thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  editColumnDialog(table: table, column: columns[selectedIndex!]);
                },
                child: const Text('Rename', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void deleteDialog(DBTable table, DBColumn column) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Column'),
          content: Text('Are you sure you wanna delete:\n\n\n- ${column.name}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await StructuurManager.deleteColumn(table, column);
                  if (!mounted) return;
                  Navigator.pop(context);
                  setState(() {
                    columns.remove(column);
                    selectedIndex = null;
                  });
                } catch (e) {
                  Navigator.pop(context);
                  showErrorBar(context, e.toString());
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void editColumnDialog({required DBTable table, required DBColumn column}) {
    showBottomSheet(
        context: context,
        builder: (context) {
          String name = column.name;
          final formKey = GlobalKey<FormState>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            persistentFooterButtons: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (!formKey.currentState!.validate()) return;
                    Navigator.pop(context);

                    late String message;
                    late DBColumn newColumn;

                    newColumn = column.copyWith(name: name);
                    if (column != newColumn) {
                      try {
                        await StructuurManager.editColumn(table, column, newColumn);
                        if (!mounted) return;
                        setState(() {
                          var index = columns.indexOf(column);
                          columns.remove(column);
                          columns.insert(index, newColumn);
                        });
                        message = "Rename ${newColumn.name}";
                        showWarningBar(context, message);
                      } catch (e) {
                        print(e);
                        throw "Failed to edit column: (${column.name})\nChosen name violates MYSQL naming rules";
                      }
                    } else {
                      message = "Nothing changed";
                      showWarningBar(context, message);
                    }
                  } catch (e) {
                    showErrorBar(context, e.toString());
                  }
                },
                child: const Text('Rename'),
              ),
            ],
            body: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text("Change Name",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: column.name,
                          onChanged: (value) => name = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Name'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
