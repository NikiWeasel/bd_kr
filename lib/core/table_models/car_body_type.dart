import 'package:json_annotation/json_annotation.dart';

part 'car_body_type.g.dart';

@JsonSerializable()
class CarBodyType {
  final int id;
  final String name;

  CarBodyType({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$CarBodyTypeToJson(this);

  factory CarBodyType.fromMap(Map<String, dynamic> json) =>
      _$CarBodyTypeFromJson(json);

  String getTableName() => 'car_body_types';
}
