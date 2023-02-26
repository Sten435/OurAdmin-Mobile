import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_list_view_card.dart';
import 'package:ouradmin_mobile/domein/column.dart';
import 'package:ouradmin_mobile/domein/database.dart';
import 'package:ouradmin_mobile/domein/table.dart';

class StructuurView extends StatefulWidget {
  const StructuurView({super.key});

  @override
  State<StructuurView> createState() => _StructuurViewState();
}

class _StructuurViewState extends State<StructuurView> {
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
              return CustomListViewCard(
                leading: column.name,
                tailingIcon: const Icon(null),
                leadingClick: null,
                subLeading: "${column.type},${column.keyType?.name ?? ""},${column.isNullable == true ? "null" : ""}".split(",").where((s) => s.isNotEmpty).join(" - "),
                selected: selectedIndex == index,
              );
            },
          ),
        ),
      ],
    );
  }
}
