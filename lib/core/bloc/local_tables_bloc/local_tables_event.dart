part of 'local_tables_bloc.dart';

@immutable
sealed class LocalTablesEvent {}

class FetchLocalTablesData extends LocalTablesEvent {}

class AddLocalTableRow extends LocalTablesEvent {
  final String tableName;
  final dynamic value;

  AddLocalTableRow({
    required this.tableName,
    required this.value,
  });
}

class UpdateLocalTableRow extends LocalTablesEvent {
  final String tableName;
  final dynamic value;
  final dynamic id;

  UpdateLocalTableRow({
    required this.tableName,
    required this.value,
    required this.id,
  });
}

class DeleteLocalTableRow extends LocalTablesEvent {
  final String tableName;
  final dynamic value;

  DeleteLocalTableRow({required this.tableName, required this.value});
}

class SearchLocalTableRow extends LocalTablesEvent {
  final dynamic tableRow;
  final List<SearchQuery> sqList;

  SearchLocalTableRow({required this.sqList, required this.tableRow});
}
