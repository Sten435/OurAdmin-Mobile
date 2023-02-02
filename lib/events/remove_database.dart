import 'package:ouradmin_mobile/domein/database.dart';

abstract class UpdateDatabaseEvent {
  late Database database;
}

class RemoveDatabaseEvent extends UpdateDatabaseEvent {
  RemoveDatabaseEvent({required Database database}) : super() {
    this.database = database;
  }
}
