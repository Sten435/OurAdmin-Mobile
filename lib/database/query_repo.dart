import 'package:ouradmin_mobile/database/db.dart';
import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/views/query_view/results_popup.dart';

class QueryRepo {
  static final QueryRepo _singleton = QueryRepo._internal();

  factory QueryRepo() => _singleton;
  QueryRepo._internal();

  Future<QueryResult> executeQuery(String text, ConnectionInfo connectionInfo) async {
    var conn = await Db.getConnection(connectionInfo: connectionInfo);

    var res = await conn.query(text);
    return QueryResult(results: res.toList());
  }
}
