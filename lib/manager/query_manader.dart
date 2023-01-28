import 'package:ouradmin_mobile/views/query_view/widgets/results_popup.dart';

import '../database/query_repo.dart';

class QueryManager {
  static final QueryRepo _queryRepo = QueryRepo();

  static Future<QueryResult> executeQuery(String? text) async {
    try {
      if (text?.isEmpty ?? true) throw Exception('Geen query ingevoerd');
      var result = await _queryRepo.executeQuery(text!.trim());
      if (result != null) {
        return result;
      } else {
        throw "Error while fetching result";
      }
    } catch (e) {
      rethrow;
    }
  }
}
