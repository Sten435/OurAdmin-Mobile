import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/domein/table.dart';

import '../../domein/database.dart';

part 'databases_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseState()) {
    on<DatabaseEvent>((event, emit) {
      if (event is DatabasesChanged) {
        emit(state.databasesChanged(event.databases));
      } else if (event is SelectedServerChanged) {
        emit(state.setSelectedServer(event.connectionInfo));
      } else if (event is SelectedDatabaseChanged) {
        emit(state.setSelectedDatabase(event.database));
      } else if (event is SelectedTableChanged) {
        emit(state.setSelectedTable(event.table));
      }
    });
  }
}
