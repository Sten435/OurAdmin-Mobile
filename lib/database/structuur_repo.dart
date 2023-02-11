import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/domein/table.dart';

import '../domein/column.dart';
import 'db.dart';

class StructuurRepo {
  static final StructuurRepo _singleton = StructuurRepo._internal();

  factory StructuurRepo() => _singleton;
  StructuurRepo._internal();

  Future<void> editColumn(DBTable table, DBColumn oudColumn, DBColumn nieuwColumn, ConnectionInfo conectionInfo) async {
    if (oudColumn.name != nieuwColumn.name) {
      final String query = "ALTER TABLE ${table.name} RENAME COLUMN ${oudColumn.name} TO ${nieuwColumn.name};";
      var conn = await Db.getConnection(connectionInfo: conectionInfo);
      await conn.query(query);
    }
  }

  Future<void> deleteColumn(DBTable table, DBColumn column, ConnectionInfo connectionInfo) async {
    final String query = "ALTER TABLE ${table.name} DROP COLUMN ${column.name};";
    var conn = await Db.getConnection(connectionInfo: connectionInfo);
    await conn.query(query);
  }
}
