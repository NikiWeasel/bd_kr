// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspection _$InspectionFromJson(Map<String, dynamic> json) => Inspection(
      id: (json['id'] as num).toInt(),
      inspectorName: json['inspector_name'] as String?,
      date: json['date'] as String?,
      failureReasons: json['failure_reasons'] as String?,
      passed: json['passed'] as bool?,
      mileage: (json['mileage'] as num?)?.toInt(),
      inspectionFee: (json['inspection_fee'] as num?)?.toDouble(),
      stickerFee: (json['sticker_fee'] as num?)?.toDouble(),
      carId: (json['car_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InspectionToJson(Inspection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inspector_name': instance.inspectorName,
      'date': instance.date,
      'failure_reasons': instance.failureReasons,
      'passed': instance.passed,
      'mileage': instance.mileage,
      'inspection_fee': instance.inspectionFee,
      'sticker_fee': instance.stickerFee,
      'car_id': instance.carId,
    };
