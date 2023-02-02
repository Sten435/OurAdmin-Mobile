import 'package:flutter/material.dart';
import 'package:ouradmin_mobile/database/databases_repo.dart';
import 'package:ouradmin_mobile/views/databases_view/widgets/database_list_view_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/databases/databases_bloc.dart';
import '../../domein/database.dart';
import '../alert_popups/error_popups.dart';
import '../alert_popups/success_popup.dart';

class DatabasesView extends StatefulWidget {
  const DatabasesView({super.key});

  @override
  State<DatabasesView> createState() => _DatabasesViewState();
}

class _DatabasesViewState extends State<DatabasesView> {
  @override
  Widget build(BuildContext context) {
    var databases = context.read<DatabaseBloc>().state.databases;
    if (databases.isEmpty) {
      getDatabases().then((value) {
        setState(() => context.read<DatabaseBloc>().add(DatabasesChanged(databases: value)));
      });
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          Database? selectedDatabase = state.selectedDatabase;
          return ListView.builder(
            itemCount: databases.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: CustomListViewCard(leading: databases[index].name, tailingIcon: const Icon(Icons.delete_forever), selected: databases[index].name == selectedDatabase?.name, leadingClick: () => deleteDatabase(databases[index])),
                onTap: () {
                  selectDatabase(databases[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Database>> getDatabases() {
    return DatabasesRepo.getDatabases();
  }

  deleteDatabase(Database database) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete database"),
        content: const Text("Are you sure?"),
        actions: [
          ElevatedButton(
            onPressed: () => closePopup(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              closePopup();
              bool isDeleted = await DatabasesRepo.deleteDatabase(database);
              if (!mounted) return;
              if (isDeleted) {
                showSuccessBar(context, "Database ${database.name} deleted");
                List<Database> databases = context.read<DatabaseBloc>().state.databases.where((element) => element.name != database.name).toList();
                context.read<DatabaseBloc>().add(DatabasesChanged(databases: databases));
              } else {
                showErrorBar(context, "Database ${database.name} could not be deleted");
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void closePopup() {
    Navigator.of(context).pop();
  }

  void selectDatabase(Database? data) {
    if (context.read<DatabaseBloc>().state.selectedDatabase == data) data = null;
    setState(() {
      context.read<DatabaseBloc>().add(SelectedDatabaseChanged(database: data));
    });
  }
}
