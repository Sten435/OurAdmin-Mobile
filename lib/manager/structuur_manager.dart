import '../database/structuur_repo.dart';
import '../domein/column.dart';

class StructuurManager {
  static final StructuurRepo _structuurRepo = StructuurRepo();

  static void editColumn(DBColumn oudColumn, DBColumn nieuwColumn) {
    try {
      if (oudColumn == nieuwColumn) return;
      _structuurRepo.editColumn(oudColumn, nieuwColumn);
    } catch (e) {
      print(e);
    }
  }

  static void addColumn(DBColumn newColumn) {
    try {
      _structuurRepo.addColumn(newColumn);
    } catch (e) {
      print(e);
    }
  }
}
