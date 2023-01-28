import 'package:mysql_client/mysql_client.dart';
import 'package:ouradmin_mobile/views/query_view/widgets/results_popup.dart';

class QueryRepo {
  static final QueryRepo _singleton = QueryRepo._internal();

  factory QueryRepo() => _singleton;
  QueryRepo._internal();

  Future<QueryResult> executeQuery(String text) async {
    final conn = await MySQLConnection.createConnection(
      host: "localhost",
      port: 3306,
      userName: "root",
      password: "",
      databaseName: "ouradmin",
    );

    await conn.connect();

    print("Connected");

    // update some rows
    var res = await conn.execute(text, {}, true);
    return QueryResult(hasData: true, results: await res.rowsStream.toList());
  }
}
