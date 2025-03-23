import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$CityToJson(this);

  factory City.fromMap(Map<String, dynamic> json) => _$CityFromJson(json);

  String getTableName() => 'cities';
}
