// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerInfo _$OwnerInfoFromJson(Map<String, dynamic> json) => OwnerInfo(
      ownerName: json['owner_name'] as String,
      inn: json['inn'] as String,
      cityId: (json['city_id'] as num?)?.toInt(),
      districtId: (json['district_id'] as num?)?.toInt(),
      streetId: (json['street_id'] as num?)?.toInt(),
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      organizationHead: json['organization_head'] as String?,
    );

Map<String, dynamic> _$OwnerInfoToJson(OwnerInfo instance) => <String, dynamic>{
      'owner_name': instance.ownerName,
      'inn': instance.inn,
      'city_id': instance.cityId,
      'district_id': instance.districtId,
      'street_id': instance.streetId,
      'house': instance.house,
      'apartment': instance.apartment,
      'organization_head': instance.organizationHead,
    };
