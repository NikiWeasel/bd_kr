import 'package:json_annotation/json_annotation.dart';

part 'inspection.g.dart';

@JsonSerializable()
class Inspection {
  final int id;
  final String? inspectorName;
  final DateTime? inspectionDate;
  final String? failureReasons;
  final bool? passed;
  final int? mileage;
  final double? inspectionFee;
  final double? signFee;
  final int? carId;

  Inspection({
    required this.id,
    this.inspectorName,
    this.inspectionDate,
    this.failureReasons,
    this.passed,
    this.mileage,
    this.inspectionFee,
    this.signFee,
    this.carId,
  });

  Map<String, dynamic> toMap() => _$InspectionToJson(this);

  factory Inspection.fromMap(Map<String, dynamic> json) =>
      _$InspectionFromJson(json);

  String getTableName() => 'inspections';
}
