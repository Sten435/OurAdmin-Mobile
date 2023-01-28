import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Column.dart';

class DBTable {
  late String Name;
  List<DBColumn> Columns = [];

  DBTable(name, {List<DBColumn>? columns}) {
    setName(name);
    setColumns(columns);
  }

  void setName(name) {
    if (name.isEmpty) throw Exception("Name cannot be empty");
    Name = name;
  }

  void setColumns(List<DBColumn>? columns) {
    if (columns == null) return;
    Columns = columns;
  }

// #region: Columns
  addColumn(DBColumn column) {
    Columns.add(column);
  }

  removeColumn(DBColumn column) {
    Columns.remove(column);
  }

  getColumns() {
    return Columns;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Columns': Columns.map((x) => x.toMap()).toList(),
    };
  }

  factory DBTable.fromMap(Map<String, dynamic> map) {
    return DBTable(
      map['Name'] as String,
      columns: List<DBColumn>.from(
        (map['Columns'] as List<int>).map<DBColumn>(
          (x) => DBColumn.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DBTable.fromJson(String source) =>
      DBTable.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equals
  @override
  bool operator ==(covariant DBTable other) {
    if (identical(this, other)) return true;

    return other.Name == Name && listEquals(other.Columns, Columns);
  }

  @override
  int get hashCode => Name.hashCode ^ Columns.hashCode;
// #endregion
}
