import 'dart:convert';

import 'package:ouradmin_mobile/domein/enums/db_key_type.dart';

class DBColumn {
  late String Name;
  late String Type;
  DBKeyType? KeyType;
  bool? IsNullable;

  DBColumn(String name, String type, {bool? isNullable, DBKeyType? keyType}) {
    setName(name);
    setType(type);
    setKeyType(keyType);
    setIsNullable(isNullable ?? true);
  }

  void setName(name) {
    if (name.isEmpty) throw Exception("Name cannot be empty");
    Name = name;
  }

  void setType(type) {
    if (type.isEmpty) throw Exception("Type cannot be empty");
    Type = type;
  }

  void setKeyType(DBKeyType? keyType) {
    KeyType = keyType;
  }

  void setIsNullable(bool bool) {
    IsNullable = bool;
  }

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'Type': Type,
      'KeyType': KeyType,
      'IsNullable': IsNullable,
    };
  }

  factory DBColumn.fromMap(Map<String, dynamic> map) {
    return DBColumn(
      map['Name'] as String,
      map['Type'] as String,
      isNullable: map['IsNullable'] != null ? map['IsNullable'] as bool : null,
      keyType: map['KeyType'] as DBKeyType?,
    );
  }

  String toJson() => json.encode(toMap());

  factory DBColumn.fromJson(String source) =>
      DBColumn.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equals
  @override
  bool operator ==(covariant DBColumn other) {
    if (identical(this, other)) return true;

    return other.Name == Name &&
        other.Type == Type &&
        other.KeyType == KeyType &&
        other.IsNullable == IsNullable;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
        Type.hashCode ^
        KeyType.hashCode ^
        IsNullable.hashCode;
  }
// #endregion
}
