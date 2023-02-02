import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ouradmin_mobile/domein/enums/db_key_type.dart';

class DBColumn extends Equatable {
  late String _name;
  String get name => _name;

  late String _type;
  String get type => _type;

  DBKeyType? _keyType;
  DBKeyType? get keyType => _keyType;

  bool? _isNullable;
  bool? get isNullable => _isNullable;

  DBColumn({required String name, required String type, required bool isNullable, required DBKeyType? keyType}) {
    setName(name);
    setType(type);
    setKeyType(keyType);
    setIsNullable(isNullable);
  }

// #region: Name
  void setName(name) {
    if (name.isEmpty) throw Exception("Column name cannot be empty");
    _name = name;
  }
// #endregion

// #region: Type
  void setType(type) {
    if (type.isEmpty) throw Exception("Column type cannot be empty");
    _type = type;
  }
// #endregion

// #region: KeyType
  void setKeyType(DBKeyType? keyType) {
    _keyType = keyType;
  }
// #endregion

// #region: IsNullable
  void setIsNullable(bool isNullable) {
    _isNullable = isNullable;
  }
// #endregion

// #region: Mappers
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': name,
      'Type': type,
      'KeyType': keyType,
      'IsNullable': isNullable,
    };
  }

  factory DBColumn.fromMap(Map<String, dynamic> map) {
    return DBColumn(
      name: map['Name'] as String,
      type: map['Type'] as String,
      isNullable: map['IsNullable'] as bool,
      keyType: map['KeyType'] as DBKeyType,
    );
  }

  String toJson() => json.encode(toMap());

  factory DBColumn.fromJson(String source) => DBColumn.fromMap(json.decode(source) as Map<String, dynamic>);
// #endregion

// #region: Equatable
  @override
  List<Object?> get props => [name, type, keyType, isNullable];
// #endregion
}
