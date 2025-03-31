import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

const Uuid uuid = Uuid();

@JsonSerializable()
class User {
  final String id;
  final String login;
  final String phoneNumber;

  @JsonKey(fromJson: _boolFromInt, toJson: _boolToInt)
  final bool isAdmin;
  final String password;

  User({
    String? id,
    required this.login,
    required this.phoneNumber,
    required this.isAdmin,
    required this.password,
  }) : id = id ?? uuid.v6();

  User.empty()
      : id = uuid.v6(),
        login = '',
        phoneNumber = '',
        isAdmin = false,
        password = '';

  bool isEmpty() {
    if (login == '' && login == '' && login == '') {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toMap() => _$UserToJson(this);

  factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);

  String getTableName() => 'users';

  static bool _boolFromInt(int? value) => value == 1;

  static int _boolToInt(bool value) => value ? 1 : 0;
}
