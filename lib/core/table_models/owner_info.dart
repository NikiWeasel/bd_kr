import 'package:json_annotation/json_annotation.dart';

part 'owner_info.g.dart';

@JsonSerializable()
class OwnerInfo {
  final String ownerName;
  final String inn;
  final int? cityId;
  final int? districtId;
  final int? streetId;
  final String? house;
  final String? apartment;
  final String? organizationHead;

  OwnerInfo({
    required this.ownerName,
    required this.inn,
    this.cityId,
    this.districtId,
    this.streetId,
    this.house,
    this.apartment,
    this.organizationHead,
  });

  Map<String, dynamic> toMap() => _$OwnerInfoToJson(this);

  factory OwnerInfo.fromMap(Map<String, dynamic> json) =>
      _$OwnerInfoFromJson(json);

  String getTableName() => 'owner_info';
}
