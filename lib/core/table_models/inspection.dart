import 'package:json_annotation/json_annotation.dart';

part 'inspection.g.dart';

@JsonSerializable()
class Inspection {
  final int id;
  final String? inspectorName;
  final DateTime? inspectionDate;
  final String? failureReasons;

  @JsonKey(fromJson: _boolFromInt)
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

  factory Inspection.fromJson(Map<String, dynamic> json) =>
      _$InspectionFromJson(json);

  Map<String, dynamic> toJson() => _$InspectionToJson(this);

  factory Inspection.fromMap(Map<String, dynamic> json) =>
      Inspection.fromJson(json);

  Map<String, dynamic> toMap() => toJson();

  String getTableName() => 'inspections';

  static bool? _boolFromInt(int? value) => value == null ? null : value == 1;

// static int? _boolToInt(bool? value) => value == null ? null : (value ? 1 : 0);
}
