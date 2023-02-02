import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';
import 'package:ouradmin_mobile/domein/table.dart';
import 'package:ouradmin_mobile/views/databases_view/widgets/database_list_view_card.dart';

import '../../domein/database.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  @override
  Widget build(BuildContext context) {
    final databaseState = context.read<DatabaseBloc>().state;
    final Database? selectedDatabase = databaseState.selectedDatabase;
    final selectedTable = databaseState.selectedTable;

    if (selectedDatabase == null) {
      return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('No Database Selected', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () => GoRouter.of(context).go('/'), child: const Text("Select Database")),
      ]));
    }

    final tableNames = selectedDatabase.tables;
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tableNames.length,
            itemBuilder: (context, index) {
              final tableName = selectedDatabase.tables[index];
              return GestureDetector(
                child: CustomListViewCard(
                  leading: tableName.name,
                  tailingIcon: const Icon(Icons.delete_forever),
                  leadingClick: () => {},
                  selected: tableName.name == selectedTable?.name,
                ),
                onTap: () {
                  setSelectedTable(context, tableName);
                },
              );
            },
          ),
        ),
        const Divider(color: Colors.brown, height: 0, thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () => opennewTableDialog(context),
            child: const Text('Add Table', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }

  openConformationDialog(BuildContext context, String tableName) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Table'),
          content: Text('Are you sure you wanna delete:\n\n\n- $tableName'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  opennewTableDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final textRef = TextEditingController();
        return AlertDialog(
          title: const Text('Add Table'),
          // ignore: prefer_const_constructors
          content: TextField(
            controller: textRef,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Table Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void setSelectedTable(BuildContext context, DBTable? table) {
    if (table == context.read<DatabaseBloc>().state.selectedTable) table = null;
    setState(() {
      context.read<DatabaseBloc>().add(SelectedTableChanged(table: table));
    });
  }
}
