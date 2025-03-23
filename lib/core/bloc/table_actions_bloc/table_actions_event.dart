part of 'table_actions_bloc.dart';

@immutable
sealed class TableActionsEvent {}

class FetchTablesData extends TableActionsEvent {}

class AddTableRow extends TableActionsEvent {
  final dynamic tableRow;

  AddTableRow({required this.tableRow});
}

class UpdateTableRow extends TableActionsEvent {
  final dynamic tableRow;

  UpdateTableRow({required this.tableRow});
}

class DeleteTableRow extends TableActionsEvent {
  final dynamic tableRow;

  DeleteTableRow({required this.tableRow});
}

class SearchTableRow extends TableActionsEvent {
  final dynamic tableRow;
  final List<SearchQuery> sqList;

  SearchTableRow({required this.sqList, required this.tableRow});
}
