import 'package:json_annotation/json_annotation.dart';

part 'car_brand.g.dart';

@JsonSerializable()
class CarBrand {
  final int id;
  final String name;

  CarBrand({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$CarBrandToJson(this);

  factory CarBrand.fromMap(Map<String, dynamic> json) =>
      _$CarBrandFromJson(json);

  String getTableName() => 'car_brands';
}
