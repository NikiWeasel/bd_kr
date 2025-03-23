import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final int id;
  final String name;

  District({required this.id, required this.name});

  Map<String, dynamic> toMap() => _$DistrictToJson(this);

  factory District.fromMap(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  String getTableName() => 'districts';
}
