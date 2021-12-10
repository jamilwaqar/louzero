// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..avatar = json['avatar'] == null ? null : Uri.parse(json['avatar'] as String)
  ..email = json['email'] as String? ?? ''
  ..firstname = json['firstname'] as String? ?? ''
  ..lastname = json['lastname'] as String? ?? '';

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'avatar': instance.avatar?.toString(),
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };
