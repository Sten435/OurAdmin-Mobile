import 'package:mysql_client/mysql_client.dart';
import 'package:ouradmin_mobile/views/query_view/widgets/results_popup.dart';

class QueryRepo {
  static final QueryRepo _singleton = QueryRepo._internal();

  factory QueryRepo() => _singleton;
  QueryRepo._internal();

  Future<QueryResult> executeQuery(String text) async {
    final conn = await MySQLConnection.createConnection(
      host: "10.0.2.2",
      port: 3306,
      userName: "root",
      password: "root",
      databaseName: "test",
    );

    await conn.connect();

    var res = await conn.execute(text, {}, true);
    return QueryResult(hasData: true, results: await res.rowsStream.toList());
  }
}
