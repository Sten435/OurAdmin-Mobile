part of 'databases_bloc.dart';

class DatabaseState extends Equatable {
  DatabaseState();
  List<Database> databases = [];
  ConnectionInfo? connectionInfo;
  Database? selectedDatabase;
  DBTable? selectedTable;

  DatabaseState copyWith({
    required List<Database> databases,
    required Database? selectedDatabase,
    required ConnectionInfo? connectionInfo,
    required DBTable? selectedTable,
  }) {
    return DatabaseState()
      ..databases = databases
      ..connectionInfo = connectionInfo
      ..selectedDatabase = selectedDatabase
      ..selectedTable = selectedTable;
  }

  DatabaseState databasesChanged(List<Database> databases) {
    return copyWith(
      databases: databases,
      selectedDatabase: selectedDatabase,
      connectionInfo: connectionInfo,
      selectedTable: selectedTable,
    );
  }

  DatabaseState setSelectedServer(ConnectionInfo? connectionInfo) {
    if (connectionInfo == this.connectionInfo) return this;
    return copyWith(
      selectedDatabase: null,
      selectedTable: null,
      connectionInfo: connectionInfo,
      databases: [],
    );
  }

  DatabaseState setSelectedDatabase(Database? database) {
    if (database == selectedDatabase) return this;
    if (!databases.contains(database) && database != null) throw Exception("Database is not in the list of databases");
    return copyWith(
      selectedDatabase: database,
      selectedTable: null,
      connectionInfo: connectionInfo,
      databases: databases,
    );
  }

  DatabaseState setSelectedTable(DBTable? table) {
    if (table == selectedTable) return this;
    if (selectedDatabase == null) throw Exception("No database selected");
    if (!selectedDatabase!.tables.contains(table) && table != null) throw Exception("Table is not in the list of tables");
    return copyWith(
      databases: databases,
      connectionInfo: connectionInfo,
      selectedDatabase: selectedDatabase,
      selectedTable: table,
    );
  }

  @override
  List<Object?> get props => [databases, selectedDatabase, connectionInfo, selectedTable];
}
