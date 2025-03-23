import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  final int id;
  final double? engineVolume;
  final int? colorId;
  final double? enginePower;
  final bool? allWheelDrive;
  final String? licensePlate;
  final String? model;
  final String? steeringWheel;
  final double? annualTax;
  final int? year;
  final String? engineNumber;
  final bool? stolen;
  final String? returnDate;
  final String? theftDate;
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

  Map<String, dynamic> toMap() => _$CarToJson(this);

  factory Car.fromMap(Map<String, dynamic> json) => _$CarFromJson(json);

  String getTableName() => 'cars';
}
