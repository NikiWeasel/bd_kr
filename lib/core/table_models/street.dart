import 'package:json_annotation/json_annotation.dart';

part 'street.g.dart';

@JsonSerializable()
class Street {
  final int id;
  final String name;

  Street({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$StreetToJson(this);

  factory Street.fromMap(Map<String, dynamic> json) => _$StreetFromJson(json);

  String getTableName() => 'streets';
}
