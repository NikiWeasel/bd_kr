// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      id: (json['id'] as num).toInt(),
      ownerType: json['owner_type'] as String?,
      inn: json['inn'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'owner_type': instance.ownerType,
      'inn': instance.inn,
    };
