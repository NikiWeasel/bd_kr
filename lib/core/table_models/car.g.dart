// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: (json['id'] as num).toInt(),
      engineVolume: (json['engine_volume'] as num?)?.toDouble(),
      colorId: (json['color_id'] as num?)?.toInt(),
      enginePower: (json['engine_power'] as num?)?.toDouble(),
      allWheelDrive:
          Car._boolFromInt((json['all_wheel_drive'] as num?)?.toInt()),
      licensePlate: json['license_plate'] as String?,
      model: json['model'] as String?,
      steeringWheel: json['steering_wheel'] as String?,
      annualTax: (json['annual_tax'] as num?)?.toDouble(),
      year: (json['year'] as num?)?.toInt(),
      engineNumber: json['engine_number'] as String?,
      stolen: Car._boolFromInt((json['stolen'] as num?)?.toInt()),
      returnDate: json['return_date'] == null
          ? null
          : DateTime.parse(json['return_date'] as String),
      theftDate: json['theft_date'] == null
          ? null
          : DateTime.parse(json['theft_date'] as String),
      bodyTypeId: (json['body_type_id'] as num?)?.toInt(),
      brandId: (json['brand_id'] as num?)?.toInt(),
      ownerId: (json['owner_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'engine_volume': instance.engineVolume,
      'color_id': instance.colorId,
      'engine_power': instance.enginePower,
      'all_wheel_drive': Car._boolToInt(instance.allWheelDrive),
      'license_plate': instance.licensePlate,
      'model': instance.model,
      'steering_wheel': instance.steeringWheel,
      'annual_tax': instance.annualTax,
      'year': instance.year,
      'engine_number': instance.engineNumber,
      'stolen': Car._boolToInt(instance.stolen),
      'return_date': instance.returnDate?.toIso8601String(),
      'theft_date': instance.theftDate?.toIso8601String(),
      'body_type_id': instance.bodyTypeId,
      'brand_id': instance.brandId,
      'owner_id': instance.ownerId,
    };
