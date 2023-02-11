import 'package:mysql1/mysql1.dart';
import 'package:ouradmin_mobile/error/database_connection_error.dart';
import 'package:ouradmin_mobile/domein/connection_info.dart';

class Db {
  static final Db _singleton = Db._internal();
  static MySqlConnection? _connection;
  static ConnectionInfo? _connectionInfo;
  static bool firstConnection = true;

  factory Db() => _singleton;
  Db._internal();

  static Future<MySqlConnection> getConnection({required ConnectionInfo connectionInfo}) async {
    try {
      if (_connection != null && !firstConnection && _connectionInfo == connectionInfo) {
        return _connection!;
      }

      var settings = ConnectionSettings(
        host: connectionInfo.host,
        port: connectionInfo.port,
        user: connectionInfo.username,
        password: connectionInfo.password,
        db: connectionInfo.database,
        timeout: const Duration(seconds: 5),
      );

      _connection = await MySqlConnection.connect(settings);
      await Future.delayed(const Duration(microseconds: 1));
      return _connection!;
    } catch (e) {
      throw DatabaseConnectionError(message: e is DatabaseConnectionError ? e.message : "Could not connect to database");
    }
  }
}
