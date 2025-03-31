// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inspection _$InspectionFromJson(Map<String, dynamic> json) => Inspection(
      id: (json['id'] as num).toInt(),
      inspectorName: json['inspector_name'] as String?,
      inspectionDate: json['inspection_date'] == null
          ? null
          : DateTime.parse(json['inspection_date'] as String),
      failureReasons: json['failure_reasons'] as String?,
      passed: Inspection._boolFromInt((json['passed'] as num?)?.toInt()),
      mileage: (json['mileage'] as num?)?.toInt(),
      inspectionFee: (json['inspection_fee'] as num?)?.toDouble(),
      signFee: (json['sign_fee'] as num?)?.toDouble(),
      carId: (json['car_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InspectionToJson(Inspection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inspector_name': instance.inspectorName,
      'inspection_date': instance.inspectionDate?.toIso8601String(),
      'failure_reasons': instance.failureReasons,
      'passed': Inspection._boolToInt(instance.passed),
      'mileage': instance.mileage,
      'inspection_fee': instance.inspectionFee,
      'sign_fee': instance.signFee,
      'car_id': instance.carId,
    };
