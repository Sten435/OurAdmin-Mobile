import 'package:ouradmin_mobile/database/db.dart';
import 'package:ouradmin_mobile/views/query_view/widgets/results_popup.dart';

class QueryRepo {
  static final QueryRepo _singleton = QueryRepo._internal();

  factory QueryRepo() => _singleton;
  QueryRepo._internal();

  Future<QueryResult> executeQuery(String text) async {
    var conn = await Db.getConnection();

    var res = await conn.query(text);
    return QueryResult(results: res.toList());
  }
}
