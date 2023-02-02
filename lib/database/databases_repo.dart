import 'package:ouradmin_mobile/database/db.dart';
import 'package:ouradmin_mobile/domein/column.dart';
import 'package:ouradmin_mobile/domein/database.dart';
import 'package:ouradmin_mobile/domein/enums/db_key_type.dart';

import '../domein/table.dart';

class DatabasesRepo {
  static Future<List<Database>> getDatabases() async {
    const query = "SELECT DISTINCT table_schema FROM information_schema.columns WHERE table_schema NOT IN ('information_schema', 'sys','performance_schema','mysql') ORDER BY table_schema";
    var databases = <Database>[];

    var conn = await Db.getConnection();
    var res = await conn.query(query);

    for (var row in res) {
      var name = row.first.toString();
      var tables = await _getTables(name);
      var database = Database(name: name, tables: tables);
      databases.add(database);
    }

    return databases;
  }

  static Future<bool> deleteDatabase(Database database) async {
    final query = "DROP DATABASE IF EXISTS `${database.name}`";

    try {
      var conn = await Db.getConnection();
      await conn.query(query);

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<DBTable>> _getTables(String databaseName) async {
    var query = "SELECT table_name FROM information_schema.tables WHERE table_schema = '$databaseName' ORDER BY table_name";

    var conn = await Db.getConnection();
    var res = await conn.query(query);

    var tables = <DBTable>[];
    for (var row in res) {
      String tableName = row.first.toString();
      var columns = await _getColumns(databaseName, tableName);
      tables.add(DBTable(name: tableName, columns: columns));
    }
    return tables;
  }

  static _getColumns(String databaseName, String tableName) async {
    var query = "SELECT column_name as name, is_nullable as isNullable, data_type as type, column_key as keyType FROM information_schema.columns WHERE table_schema = '$databaseName' AND table_name = '$tableName' ORDER BY ordinal_position";

    var conn = await Db.getConnection();
    var res = await conn.query(query);

    var columns = <DBColumn>[];

    for (var row in res) {
      String columnName = row["name"].toString();
      String columnType = row["type"].toString();
      String columnKeyType = row["keyType"].toString();
      String columnIsNullable = row["isNullable"].toString();

      DBKeyType? isPrimaryKey;
      switch (columnKeyType) {
        case "PRI":
          isPrimaryKey = DBKeyType.primaryKey;
          break;
      }
      var isNullable = columnIsNullable == "YES" ? true : false;

      var column = DBColumn(name: columnName, type: columnType, keyType: isPrimaryKey, isNullable: isNullable);
      columns.add(column);
    }
    return columns;
  }
}
