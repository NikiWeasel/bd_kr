part of 'table_actions_bloc.dart';

// @immutable
// sealed class TableActionsState {}
//
// final class TableActionsInitial extends TableActionsState {}

@immutable
sealed class TableActionsState {}

final class TableActionsInitial extends TableActionsState {}

class TableActionsLoading extends TableActionsState {}

class TableActionsLoaded extends TableActionsState {
  final AllTables allTables;

  TableActionsLoaded({required this.allTables});
}

class TableActionsError extends TableActionsState {
  final String errorMessage;

  TableActionsError({required this.errorMessage});
}
