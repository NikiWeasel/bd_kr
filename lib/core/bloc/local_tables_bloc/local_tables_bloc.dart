import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bd_kr/core/models/all_tables.dart';
import 'package:bd_kr/core/services/sql_service.dart';

import 'package:bd_kr/core/models/search_query.dart';

part 'local_tables_event.dart';

part 'local_tables_state.dart';

class LocalTablesBloc extends Bloc<LocalTablesEvent, LocalTablesState> {
  final SqlService sqlService;
  AllTables localTables = AllTables.emptyTables();

  LocalTablesBloc(this.sqlService) : super(LocalTablesInitial()) {
    on<FetchLocalTablesData>((event, emit) async {
      emit(LocalTablesLoading());
      try {
        localTables = await sqlService.loadTables();
        emit(LocalTablesLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());

        emit(LocalTablesError(errorMessage: e.toString()));
      }
    });

    on<AddLocalTableRow>((event, emit) async {
      emit(LocalTablesLoading());
      try {
        localTables.addElement(event.tableName, event.value);

        print('localTables.parentTable[event.tableName]');
        print(localTables.parentTable[event.tableName]);
        emit(LocalTablesLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());

        emit(LocalTablesError(errorMessage: e.toString()));
      }
    });

    on<DeleteLocalTableRow>((event, emit) async {
      emit(LocalTablesLoading());
      try {
        localTables.removeElement(event.tableName, event.value);
        emit(LocalTablesLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());

        emit(LocalTablesError(errorMessage: e.toString()));
      }
    });

    on<UpdateLocalTableRow>((event, emit) async {
      emit(LocalTablesLoading());
      try {
        localTables.updateElement(event.tableName, event.value, event.id);
        emit(LocalTablesLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());

        emit(LocalTablesError(errorMessage: e.toString()));
      }
    });

    on<SearchLocalTableRow>((event, emit) async {
      emit(LocalTablesLoading());
      try {
        var newTable = await sqlService.searchInTable(
            allTables: localTables,
            tableRow: event.tableRow,
            sqList: event.sqList);
        // var newTables = AllTables.emptyTables();
        print('localTables.parentTable[event.tableName]');
        print(localTables.parentTable[event.tableName]);

        localTables.insertFilteredTable(event.tableName, newTable);

        emit(LocalTablesLoaded(allTables: localTables));
      } catch (e) {
        print(e.toString());
        emit(LocalTablesError(errorMessage: e.toString()));
      }
    });
  }
}
