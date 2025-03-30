import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone {
  final int id;
  final int? ownerId;
  final String? phoneNumber;

  Phone({
    required this.id,
    this.ownerId,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() => _$PhoneToJson(this);

  factory Phone.fromMap(Map<String, dynamic> json) => _$PhoneFromJson(json);

  String getTableName() => 'phones';
}
