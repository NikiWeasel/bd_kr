// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      id: (json['id'] as num).toInt(),
      ownerId: (json['owner_id'] as num?)?.toInt(),
      number: json['number'] as String?,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'number': instance.number,
    };
