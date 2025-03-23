// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'street.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Street _$StreetFromJson(Map<String, dynamic> json) => Street(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$StreetToJson(Street instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
