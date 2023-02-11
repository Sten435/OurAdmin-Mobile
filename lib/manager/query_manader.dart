import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/views/query_view/results_popup.dart';

import '../database/query_repo.dart';

class QueryManager {
  static final QueryRepo _queryRepo = QueryRepo();

  static Future<QueryResult> executeQuery(String? text, ConnectionInfo connectionInfo) async {
    try {
      if (text?.isEmpty ?? true) throw Exception('Geen query ingevoerd');
      return await _queryRepo.executeQuery(text!.trim(), connectionInfo);
    } catch (e) {
      rethrow;
    }
  }
}
