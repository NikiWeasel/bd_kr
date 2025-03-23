import 'package:bd_kr/core/models/all_tables.dart';
import 'package:bd_kr/core/services/sql_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bd_kr/core/models/search_query.dart';

part 'table_actions_event.dart';

part 'table_actions_state.dart';

class TableActionsBloc extends Bloc<TableActionsEvent, TableActionsState> {
  final SqlService sqlService;

  TableActionsBloc(this.sqlService) : super(TableActionsInitial()) {
    on<AddTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        await sqlService.addTableRow(event.tableRow);
        emit(TableActionsAdded(tableRow: event.tableRow));
      } catch (e) {
        print(e.toString());
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<UpdateTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        sqlService.editTableRow(event.tableRow);
        emit(TableActionsUpdated(tableRow: event.tableRow, id: event.id));
      } catch (e) {
        print(e.toString());

        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<DeleteTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        sqlService.deleteTableRow(event.tableRow);
        emit(TableActionsDeleted(tableRow: event.tableRow));
      } catch (e) {
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });
  }
}
