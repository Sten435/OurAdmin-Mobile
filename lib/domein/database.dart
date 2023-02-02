// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, prefer_final_fields, constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'table.dart';

class Database extends Equatable {
  List<DBTable> _tables = [];
  List<DBTable> get tables => _tables;

  late String _name;
  String get name => _name;

  Database({required String name, required List<DBTable> tables}) {
    setName(name);
    setTables(tables);
  }

// #region: Tables
  void setTables(List<DBTable> tables) {
    _tables = tables;
  }

  void addTable(DBTable table) {
    _tables.add(table);
  }

  void removeTable(DBTable table) {
    _tables.remove(table);
  }

  List<DBTable> getTables() {
    return tables;
  }
// #endregion

// #region: Name
  void setName(String name) {
    if (name.isEmpty) throw Exception("Database name cannot be empty");
    _name = name;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Tables': tables.map((x) => x.toMap()).toList(),
    };
  }

  factory Database.fromMap(Map<String, dynamic> map) {
    return Database(
      name: map['name'] as String,
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

// #region: Equatable
  @override
  List<Object?> get props => [tables, name];
// #endregion
}
