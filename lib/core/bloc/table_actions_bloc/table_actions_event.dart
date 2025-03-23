part of 'table_actions_bloc.dart';

@immutable
sealed class TableActionsEvent {}

// class FetchTablesData extends TableActionsEvent {}

class AddTableRow extends TableActionsEvent {
  final dynamic tableRow;

  AddTableRow({required this.tableRow});
}

class UpdateTableRow extends TableActionsEvent {
  final dynamic tableRow;
  final dynamic id;

  UpdateTableRow({required this.id, required this.tableRow});
}

class DeleteTableRow extends TableActionsEvent {
  final dynamic tableRow;

  DeleteTableRow({required this.tableRow});
}
