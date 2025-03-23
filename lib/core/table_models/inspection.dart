import 'package:json_annotation/json_annotation.dart';

part 'inspection.g.dart';

@JsonSerializable()
class Inspection {
  final int id;
  final String? inspectorName;
  final String? date;
  final String? failureReasons;
  final bool? passed;
  final int? mileage;
  final double? inspectionFee;
  final double? stickerFee;
  final int? carId;

  Inspection({
    required this.id,
    this.inspectorName,
    this.date,
    this.failureReasons,
    this.passed,
    this.mileage,
    this.inspectionFee,
    this.stickerFee,
    this.carId,
  });

  Map<String, dynamic> toMap() => _$InspectionToJson(this);

  factory Inspection.fromMap(Map<String, dynamic> json) =>
      _$InspectionFromJson(json);

  String getTableName() => 'inspections';
}
