part of 'databases_bloc.dart';

abstract class DatabaseEvent {}

class DatabasesChanged extends DatabaseEvent {
  DatabasesChanged({required this.databases});
  final List<Database> databases;
}

class SelectedServerChanged extends DatabaseEvent {
  SelectedServerChanged({required this.connectionInfo});
  final ConnectionInfo? connectionInfo;
}

class SelectedDatabaseChanged extends DatabaseEvent {
  SelectedDatabaseChanged({required this.database});
  final Database? database;
}

class SelectedTableChanged extends DatabaseEvent {
  SelectedTableChanged({required this.table});
  final DBTable? table;
}
