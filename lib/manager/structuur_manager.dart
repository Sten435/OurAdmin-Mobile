import '../database/structuur_repo.dart';
import '../domein/column.dart';
import '../domein/table.dart';

class StructuurManager {
  static final StructuurRepo _structuurRepo = StructuurRepo();

  static Future<void> editColumn(DBTable table, DBColumn oudColumn, DBColumn nieuwColumn) async {
    if (oudColumn == nieuwColumn) return;
    if (nieuwColumn.name.trim().isEmpty) throw Exception('Column name cannot be empty');

    await _structuurRepo.editColumn(table, oudColumn, nieuwColumn);
  }

  static Future<void> deleteColumn(DBTable table, DBColumn column) async {
    await _structuurRepo.deleteColumn(table, column);
  }
}
