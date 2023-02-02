part of 'databases_bloc.dart';

class DatabaseState extends Equatable {
  DatabaseState();
  List<Database> databases = [];
  Database? selectedDatabase;
  DBTable? selectedTable;

  DatabaseState copyWith({
    required List<Database> databases,
    required Database? selectedDatabase,
    required DBTable? selectedTable,
  }) {
    return DatabaseState()
      ..databases = databases
      ..selectedDatabase = selectedDatabase
      ..selectedTable = selectedTable;
  }

  DatabaseState databasesChanged(List<Database> databases) {
    return copyWith(databases: databases, selectedDatabase: selectedDatabase, selectedTable: selectedTable);
  }

  DatabaseState setSelectedDatabase(Database? database) {
    if (database == selectedDatabase) return this;
    if (!databases.contains(database) && database != null) throw Exception("Database is not in the list of databases");
    return copyWith(selectedDatabase: database, selectedTable: null, databases: databases);
  }

  DatabaseState setSelectedTable(DBTable? table) {
    if (table == selectedTable) return this;
    if (selectedDatabase == null) throw Exception("No database selected");
    if (!selectedDatabase!.tables.contains(table) && table != null) throw Exception("Table is not in the list of tables");
    return copyWith(selectedTable: table, databases: databases, selectedDatabase: selectedDatabase);
  }

  @override
  List<Object?> get props => [databases, selectedDatabase, selectedTable];
}
