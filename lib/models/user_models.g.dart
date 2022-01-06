// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..avatar = json['avatar'] == null ? null : Uri.parse(json['avatar'] as String)
  ..email = json['email'] as String? ?? ''
  ..firstname = json['firstname'] as String? ?? ''
  ..lastname = json['lastname'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..serviceAddress = json['serviceAddress'] as String? ?? ''
  ..activeCompanyId = json['activeCompanyId'] as String? ?? ''
  ..customerTypes = (json['customerTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..jobTypes =
      (json['jobTypes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [];

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'avatar': instance.avatar?.toString(),
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'serviceAddress': instance.serviceAddress,
      'activeCompanyId': instance.activeCompanyId,
      'customerTypes': instance.customerTypes,
      'jobTypes': instance.jobTypes,
    };

InviteModel _$InviteModelFromJson(Map<String, dynamic> json) => InviteModel()
  ..email = json['email'] as String? ?? ''
  ..objectId = json['objectId'] as String?
  ..inviteCode = json['inviteCode'] as String? ?? ''
  ..created = json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String);

Map<String, dynamic> _$InviteModelToJson(InviteModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'objectId': instance.objectId,
      'inviteCode': instance.inviteCode,
      'created': instance.created?.toIso8601String(),
    };
