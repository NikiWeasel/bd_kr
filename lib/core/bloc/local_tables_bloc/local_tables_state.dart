part of 'local_tables_bloc.dart';

@immutable
sealed class LocalTablesState {}

final class LocalTablesInitial extends LocalTablesState {}

class LocalTablesLoading extends LocalTablesState {}

class LocalTablesLoaded extends LocalTablesState {
  final AllTables allTables;

  LocalTablesLoaded({required this.allTables});
}

class LocalTablesError extends LocalTablesState {
  final String errorMessage;

  LocalTablesError({required this.errorMessage});
}
