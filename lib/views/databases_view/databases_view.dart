import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_list_view_card.dart';
import 'package:ouradmin_mobile/manager/databases_manager.dart';

import '../../bloc/databases/databases_bloc.dart';
import '../../error/database_connection_error.dart';
import '../../domein/database.dart';
import '../alert_popups/error_popups.dart';

class DatabasesView extends StatefulWidget {
  DatabasesView({super.key});
  late Future<List<Database>> databases;

  @override
  State<DatabasesView> createState() => _DatabasesViewState();
}

class _DatabasesViewState extends State<DatabasesView> {
  @override
  void initState() {
    super.initState();
    var memoryDatabases = context.read<DatabaseBloc>().state.databases;
    widget.databases = Future.value(memoryDatabases);
    if (memoryDatabases.isEmpty) {
      var databases = getDatabases(context);
      widget.databases = databases;
      databases.then((value) {
        setState(() => context.read<DatabaseBloc>().add(DatabasesChanged(databases: value)));
      }).onError((e, stackTrace) {
        showErrorBar(context, e.toString(), duration: const Duration(seconds: 30));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedDatabase = context.read<DatabaseBloc>().state.selectedDatabase;
    return FutureBuilder<List<Database>>(
      future: widget.databases,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: CustomListViewCard(
                      leading: snapshot.data![index].name,
                      tailingIcon: const Icon(Icons.circle_outlined),
                      selected: snapshot.data![index] == selectedDatabase,
                      leadingClick: () {},
                    ),
                    onTap: () => selectDatabase(database: snapshot.data![index]));
              });
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
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

  void selectDatabase({required Database? database}) {
    if (context.read<DatabaseBloc>().state.selectedDatabase == database) database = null;
    setState(() {
      context.read<DatabaseBloc>().add(SelectedDatabaseChanged(database: database));
    });
  }
}
