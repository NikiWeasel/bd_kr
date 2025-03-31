import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  final int id;
  final double? engineVolume;
  final int? colorId;
  final double? enginePower;

  @JsonKey(
    fromJson: _boolFromInt,
  )
  final bool? allWheelDrive;

  final String? licensePlate;
  final String? model;
  final String? steeringWheel;
  final double? annualTax;
  final int? year;
  final String? engineNumber;

  @JsonKey(
    fromJson: _boolFromInt,
  )
  final bool? stolen;

  final DateTime? returnDate;
  final DateTime? theftDate;
  final int? bodyTypeId;
  final int? brandId;
  final int? ownerId;

  Car({
    required this.id,
    this.engineVolume,
    this.colorId,
    this.enginePower,
    this.allWheelDrive,
    this.licensePlate,
    this.model,
    this.steeringWheel,
    this.annualTax,
    this.year,
    this.engineNumber,
    this.stolen,
    this.returnDate,
    this.theftDate,
    this.bodyTypeId,
    this.brandId,
    this.ownerId,
  });

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);

  factory Car.fromMap(Map<String, dynamic> json) => Car.fromJson(json);

  Map<String, dynamic> toMap() => toJson();

  String getTableName() => 'cars';

  static bool? _boolFromInt(int? value) => value == null ? null : value == 1;

// static int? _boolToInt(bool? value) => value == null ? null : (value ? 1 : 0);
}
