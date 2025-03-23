import 'package:json_annotation/json_annotation.dart';

part 'car_color.g.dart';

@JsonSerializable()
class CarColor {
  final int id;
  final String name;

  CarColor({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$CarColorToJson(this);

  factory CarColor.fromMap(Map<String, dynamic> json) =>
      _$CarColorFromJson(json);

  String getTableName() => 'car_colors';
}
