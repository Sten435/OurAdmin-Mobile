import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_list_view_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ouradmin_mobile/manager/databases_manager.dart';

import '../../bloc/databases/databases_bloc.dart';
import '../../error/database_connection_error.dart';
import '../../domein/database.dart';
import '../alert_popups/error_popups.dart';
import '../alert_popups/success_popup.dart';

class DatabasesView extends StatefulWidget {
  DatabasesView({super.key});
  List<Database> databases = [];

  @override
  State<DatabasesView> createState() => _DatabasesViewState();
}

class _DatabasesViewState extends State<DatabasesView> {
  @override
  void initState() {
    super.initState();
    widget.databases = context.read<DatabaseBloc>().state.databases;
    if (widget.databases.isEmpty) {
      getDatabases(context).then((value) {
        setState(() => context.read<DatabaseBloc>().add(DatabasesChanged(databases: value)));
      }).onError((e, stackTrace) {
        showErrorBar(context, e.toString(), duration: const Duration(seconds: 30));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          Database? selectedDatabase = state.selectedDatabase;
          return ListView.builder(
            itemCount: widget.databases.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: CustomListViewCard(leading: widget.databases[index].name, tailingIcon: const Icon(Icons.delete_forever), selected: widget.databases[index].name == selectedDatabase?.name, leadingClick: () => deleteDatabase(widget.databases[index])),
                onTap: () {
                  selectDatabase(widget.databases[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Database>> getDatabases(BuildContext context) {
    try {
      var connectionInfo = context.read<DatabaseBloc>().state.connectionInfo;
      if (connectionInfo == null) {
        GoRouter.of(context).go('/');
        throw DatabaseConnectionError(message: "No server connected");
      }
      return DatabasesManager.getDatabases(connectionInfo: connectionInfo);
    } catch (e) {
      if (e is DatabaseConnectionError) {
        showErrorBar(context, e.toString());
      }
      return Future.value([]);
    }
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
              var connectionInfo = context.read<DatabaseBloc>().state.connectionInfo;
              if (connectionInfo == null) throw DatabaseConnectionError(message: "No server connected");
              bool isDeleted = await DatabasesManager.deleteDatabase(database: database, connectionInfo: connectionInfo);
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
