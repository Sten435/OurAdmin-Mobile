import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'column.dart';

class DBTable extends Equatable {
  late String _name;
  String get name => _name;

  List<DBColumn> _columns = [];
  List<DBColumn> get columns => _columns;

  DBTable({required String name, List<DBColumn>? columns}) {
    setName(name);
    setColumns(columns);
  }

// #region: Name
  void setName(name) {
    if (name.isEmpty) throw Exception("Name cannot be empty");
    _name = name;
  }
// #endregion

// #region: Columns
  void setColumns(List<DBColumn>? columns) {
    if (columns == null) throw Exception("Columns cannot be null");
    _columns = columns;
  }

  addColumn(DBColumn column) {
    columns.add(column);
  }

  removeColumn(DBColumn column) {
    columns.remove(column);
  }

  getColumns() {
    return columns;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': name,
      'Columns': columns.map((x) => x.toMap()).toList(),
    };
  }

  factory DBTable.fromMap(Map<String, dynamic> map) {
    return DBTable(
      name: map['Name'] as String,
      columns: List<DBColumn>.from(
        (map['Columns'] as List<int>).map<DBColumn>(
          (x) => DBColumn.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DBTable.fromJson(String source) => DBTable.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equatable
  @override
  List<Object?> get props => [name, columns];
// #endregion
}
