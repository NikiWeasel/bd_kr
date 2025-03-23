import 'package:bd_kr/core/models/all_tables.dart';
import 'package:bd_kr/core/services/sql_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bd_kr/core/models/search_query.dart';

part 'table_actions_event.dart';

part 'table_actions_state.dart';

class TableActionsBloc extends Bloc<TableActionsEvent, TableActionsState> {
  final SqlService sqlService;
  AllTables localTables = AllTables.emptyTables();

  TableActionsBloc(this.sqlService) : super(TableActionsInitial()) {
    on<FetchTablesData>((event, emit) async {
      emit(TableActionsLoading());
      try {
        localTables = await sqlService.loadTables();
        emit(TableActionsLoaded(allTables: localTables));
      } catch (e) {
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<AddTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        sqlService.addTableRow(event.tableRow);
        localTables = await sqlService.loadTables();
        emit(TableActionsLoaded(allTables: localTables));
      } catch (e) {
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<UpdateTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        sqlService.editTableRow(event.tableRow);
        localTables = await sqlService.loadTables();
        emit(TableActionsLoaded(allTables: localTables));
      } catch (e) {
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<DeleteTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        sqlService.deleteTableRow(event.tableRow);
        localTables = await sqlService.loadTables();
        emit(TableActionsLoaded(allTables: localTables));
      } catch (e) {
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });

    on<SearchTableRow>((event, emit) async {
      emit(TableActionsLoading());
      try {
        localTables =
            await sqlService.searchInTable(event.tableRow, event.sqList);

        emit(TableActionsLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());
        emit(TableActionsError(errorMessage: e.toString()));
      }
    });
  }
}
