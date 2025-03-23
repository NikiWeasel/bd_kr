// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      login: json['login'] as String,
      phoneNumber: json['phone_number'] as String,
      isAdmin: json['is_admin'] as bool,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'phone_number': instance.phoneNumber,
      'is_admin': instance.isAdmin,
      'password': instance.password,
    };
