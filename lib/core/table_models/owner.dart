import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner {
  final int id;
  final String? ownerType;
  final String? inn;

  Owner({
    required this.id,
    this.ownerType,
    this.inn,
  });

  Map<String, dynamic> toMap() => _$OwnerToJson(this);

  factory Owner.fromMap(Map<String, dynamic> json) => _$OwnerFromJson(json);

  String getTableName() => 'owners';
}
