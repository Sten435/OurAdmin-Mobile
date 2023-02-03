import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

import '../bloc/databases/databases_bloc.dart';
import '../router/router.dart';

class Db {
  static final Db _singleton = Db._internal();
  static MySqlConnection? _connection;
  static bool firstConnection = true;

  factory Db() => _singleton;
  Db._internal();

  static Future<MySqlConnection> getConnection() async {
    try {
      if (_connection != null && !firstConnection) {
        return _connection!;
      }

      // ignore: invalid_use_of_visible_for_testing_member
      BuildContext? context = routerConfig.routeConfiguration.navigatorKey.currentState?.context;
      var settings = ConnectionSettings(
        host: dotenv.env['HOST'].toString(),
        port: int.parse(dotenv.env['PORT'].toString()),
        user: dotenv.env['USERNAME'].toString(),
        password: dotenv.env['PWD'].toString(),
        db: context?.read<DatabaseBloc>().state.selectedDatabase?.name,
      );

      _connection = await MySqlConnection.connect(settings);
      await Future.delayed(const Duration(microseconds: 1));
    } catch (e) {
      print(e);
    }

    return _connection!;
  }
}
