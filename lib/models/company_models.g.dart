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
  ..admins =
      (json['admins'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..users =
      (json['users'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
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
      'admins': instance.admins,
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
