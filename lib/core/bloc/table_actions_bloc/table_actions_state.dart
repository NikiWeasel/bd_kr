part of 'table_actions_bloc.dart';

@immutable
sealed class TableActionsState {}

final class TableActionsInitial extends TableActionsState {}

class TableActionsLoading extends TableActionsState {}

class TableActionsAdded extends TableActionsState {
  final dynamic tableRow;

  TableActionsAdded({required this.tableRow});
}

class TableActionsUpdated extends TableActionsState {
  final dynamic tableRow;
  final dynamic id;

  TableActionsUpdated({
    required this.tableRow,
    required this.id,
  });
}

class TableActionsDeleted extends TableActionsState {
  final dynamic tableRow;

  TableActionsDeleted({required this.tableRow});
}

class TableActionsError extends TableActionsState {
  final String errorMessage;

  TableActionsError({required this.errorMessage});
}
