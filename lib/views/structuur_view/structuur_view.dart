import 'package:flutter/material.dart';
import 'package:ouradmin_mobile/domein/enums/db_key_type.dart';

import '../../domein/column.dart';
import '../../manager/structuur_manager.dart';
import '../alert_popups/error_popups.dart';
import 'widgets/custom_checkbox.dart';
import 'widgets/custom_combo_box.dart';

class StructuurView extends StatefulWidget {
  const StructuurView({super.key});

  @override
  State<StructuurView> createState() => _StructuurViewState();
}

class _StructuurViewState extends State<StructuurView> {
  final List<DBColumn> columns = List<DBColumn>.generate(
    10,
    (i) => DBColumn("Name: ${i + 1}", "Type: ${i + 1}",
        keyType: null, isNullable: true),
  );

  final typeNames = List<String>.generate(10, (i) => "Type: ${i + 1}");
  int? selectedIndex;

  Container columnListTile(int index, DBColumn column) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: selectedIndex == index
              ? Colors.brown.shade500
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            if (selectedIndex == index) {
              selectedIndex = null;
            } else {
              selectedIndex = index;
            }
          });
        },
        title: Text(column.Name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(
          "${column.Type},${column.KeyType?.name ?? ""},${column.IsNullable == true ? "null" : ""}"
              .split(",")
              .where((s) => s.isNotEmpty)
              .join(" - "),
        ),
        trailing: selectedIndex == index
            ? RawMaterialButton(
                onPressed: () => deleteDialog(column),
                fillColor: Colors.brown,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }

  Widget footerButtons() {
    return Column(
      children: [
        const Divider(color: Colors.brown, height: 0, thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => columnDialog(),
                child: const Text('Add Column', style: TextStyle(fontSize: 20)),
              ),
              if (selectedIndex != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600),
                  onPressed: () {
                    columnDialog(column: columns[selectedIndex!]);
                  },
                  child:
                      const Text('Edit Column', style: TextStyle(fontSize: 20)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void deleteDialog(DBColumn column) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Column'),
          content: Text('Are you sure you wanna delete:\n\n\n- ${column.Name}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  columns.remove(column);
                  selectedIndex = null;
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void columnDialog({DBColumn? column}) {
    showBottomSheet(
        context: context,
        builder: (context) {
          String? type = column?.Type;
          String? name = column?.Name;
          DBKeyType? keyType = column?.KeyType;
          bool isNullable = column?.IsNullable ?? true;
          final formKey = GlobalKey<FormState>();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            persistentFooterButtons: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  Navigator.pop(context);

                  final newColumn = DBColumn(
                    name!,
                    type!,
                    keyType: keyType,
                    isNullable: isNullable,
                  );

                  String message = "Added ${newColumn.Name}";

                  if (column == null) {
                    StructuurManager.addColumn(newColumn);

                    setState(() {
                      columns.add(newColumn);
                    });
                  } else {
                    if (column != newColumn) {
                      StructuurManager.editColumn(column, newColumn);
                      setState(() {
                        columns.remove(column);
                        columns.add(newColumn);
                      });
                      message = "Edited ${newColumn.Name}";
                    } else {
                      message = "Nothing changed";
                    }
                  }

                  showWarningBar(context, message);
                },
                child: Text(column == null ? 'Add' : 'Edit'),
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
                        Text("${column == null ? "Added new" : "Edit"} column",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: column?.Name,
                          onChanged: (value) => name = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Name'),
                        ),
                        const SizedBox(height: 20),
                        CustomComboBox(
                          typeNames,
                          selectedItem: column?.Type,
                          placeholder: "Type",
                          borderText: "Type",
                          onChanged: (value) => setState(() => type = value),
                        ),
                        const SizedBox(height: 20),
                        CustomComboBox(
                          selectedItem: column?.KeyType?.name,
                          DBKeyType.values.map((e) => e.name).toList(),
                          placeholder: "Key",
                          borderText: "Key",
                          onChanged: (value) => setState(() => keyType =
                              DBKeyType.values.firstWhere(
                                  (element) => element.name == value)),
                        ),
                        const SizedBox(height: 20),
                        CustomCheckBox("Nullable",
                            defaultValue: isNullable,
                            onChanged: (value) =>
                                setState(() => isNullable = value)),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: columns.length,
            itemBuilder: (context, index) =>
                columnListTile(index, columns[index]),
          ),
        ),
        footerButtons(),
      ],
    );
  }
}
