// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel()
  ..objectId = json['objectId'] as String?
  ..ownerId = json['ownerId'] as String?
  ..avatar = json['avatar'] == null ? null : Uri.parse(json['avatar'] as String)
  ..website = json['website'] as String? ?? ''
  ..users = (json['users'] as List<dynamic>?)
          ?.map((e) => CompanyUserModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..name = json['name'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..industries = (json['industries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..status = $enumDecodeNullable(_$CompanyStatusEnumMap, json['status']) ??
      CompanyStatus.active
  ..address = json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'ownerId': instance.ownerId,
      'avatar': instance.avatar?.toString(),
      'website': instance.website,
      'users': instance.users,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'industries': instance.industries,
      'status': _$CompanyStatusEnumMap[instance.status],
      'address': instance.address,
    };

const _$CompanyStatusEnumMap = {
  CompanyStatus.active: 'active',
  CompanyStatus.cancel: 'cancel',
};

CompanyUserModel _$CompanyUserModelFromJson(Map<String, dynamic> json) =>
    CompanyUserModel(
      userId: json['userId'] as String,
      invited: json['invited'] as int?,
      accepted: json['accepted'] as int?,
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      userRole: $enumDecode(_$UserRoleEnumMap, json['userRole']),
    );

Map<String, dynamic> _$CompanyUserModelToJson(CompanyUserModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'invited': instance.invited,
      'accepted': instance.accepted,
      'status': _$UserStatusEnumMap[instance.status],
      'userRole': _$UserRoleEnumMap[instance.userRole],
    };

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.inactive: 'inactive',
  UserStatus.invited: 'invited',
};

const _$UserRoleEnumMap = {
  UserRole.owner: 'owner',
  UserRole.admin: 'admin',
  UserRole.user: 'user',
};
