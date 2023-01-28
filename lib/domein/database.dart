// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, prefer_final_fields, constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Table.dart';
import 'connection_info.dart';

class Database {
  ConnectionInfo _connectionInfo;
  List<DBTable> Tables = [];
  String name;

  Database(this._connectionInfo, this.name, {List<DBTable>? tables}) {
    setTables(tables);
  }

  void setTables(List<DBTable>? tables) {
    if (tables == null) return;
    Tables = tables;
  }

// #region: ConnectionInfo
  ConnectionInfo getConnectionInfo() {
    return _connectionInfo;
  }

  setConnectionInfo(ConnectionInfo connectionInfo) {
    _connectionInfo = connectionInfo;
  }
// #endregion

// #region: Tables
  addTable(DBTable table) {
    Tables.add(table);
  }

  removeTable(DBTable table) {
    Tables.remove(table);
  }

  getTables() {
    return Tables;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_connectionInfo': _connectionInfo.toMap(),
      'Tables': Tables.map((x) => x.toMap()).toList(),
    };
  }

  factory Database.fromMap(Map<String, dynamic> map) {
    return Database(
      ConnectionInfo.fromMap(map['_connectionInfo'] as Map<String, dynamic>),
      map['name'] as String,
      tables: List<DBTable>.from(
        (map['Tables'] as List<int>).map<DBTable>(
          (x) => DBTable.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Database.fromJson(String source) => Database.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equals
  @override
  bool operator ==(covariant Database other) {
    if (identical(this, other)) return true;

    return other._connectionInfo == _connectionInfo && listEquals(other.Tables, Tables);
  }

  @override
  int get hashCode {
    return _connectionInfo.hashCode ^ Tables.hashCode;
  }
// #endregion
}
