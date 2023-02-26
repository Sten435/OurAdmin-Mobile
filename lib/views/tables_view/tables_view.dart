import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';
import 'package:ouradmin_mobile/domein/table.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_list_view_card.dart';

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
                  tailingIcon: const Icon(Icons.circle_outlined),
                  leadingClick: null,
                  selected: tableName.name == selectedTable?.name,
                ),
                onTap: () {
                  setSelectedTable(context, tableName);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void setSelectedTable(BuildContext context, DBTable? table) {
    if (table == context.read<DatabaseBloc>().state.selectedTable) table = null;
    setState(() {
      context.read<DatabaseBloc>().add(SelectedTableChanged(table: table));
    });
  }
}
