import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Db {
  static final Db _singleton = Db._internal();
  static MySqlConnection? _connection;

  factory Db() => _singleton;
  Db._internal();

  static Future<MySqlConnection> getConnection() async {
    if (_connection != null) return _connection!;

    var settings = ConnectionSettings(
      host: dotenv.env['HOST'].toString(),
      port: int.parse(dotenv.env['PORT'].toString()),
      user: dotenv.env['USERNAME'].toString(),
      password: dotenv.env['PWD'].toString(),
      db: dotenv.env['DATABASE'].toString(),
    );

    _connection = await MySqlConnection.connect(settings);
    await Future.delayed(const Duration(microseconds: 1));

    return _connection!;
  }
}
