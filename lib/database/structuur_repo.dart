import '../domein/column.dart';

class StructuurRepo {
  static final StructuurRepo _singleton = StructuurRepo._internal();

  factory StructuurRepo() => _singleton;
  StructuurRepo._internal();

  void editColumn(DBColumn oudColumn, DBColumn nieuwColumn) {}

  void addColumn(DBColumn newColumn) {}
}
