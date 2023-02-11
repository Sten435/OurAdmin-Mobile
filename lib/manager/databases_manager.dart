import 'package:ouradmin_mobile/database/databases_repo.dart';
import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/domein/database.dart';
import 'package:ouradmin_mobile/error/databases_mananger_error.dart';

class DatabasesManager {
  static Future<List<Database>> getDatabases({required ConnectionInfo connectionInfo}) async {
    try {
      return DatabasesRepo.getDatabases(connectionInfo: connectionInfo);
    } catch (e) {
      print(e);
      throw DatabasesManagerError(message: "Could not get databases");
    }
  }

  static deleteDatabase({required ConnectionInfo connectionInfo, required Database database}) {
    try {
      return DatabasesRepo.deleteDatabase(connectionInfo: connectionInfo, database: database);
    } catch (e) {
      print(e);
      throw DatabasesManagerError(message: "Could not delete database");
    }
  }
}
