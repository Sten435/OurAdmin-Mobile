part of 'databases_bloc.dart';

abstract class DatabaseEvent {}

class DatabasesChanged extends DatabaseEvent {
  DatabasesChanged({required this.databases});
  final List<Database> databases;
}

class SelectedDatabaseChanged extends DatabaseEvent {
  SelectedDatabaseChanged({required this.database});
  final Database? database;
}

class SelectedTableChanged extends DatabaseEvent {
  SelectedTableChanged({required this.table});
  final DBTable? table;
}
