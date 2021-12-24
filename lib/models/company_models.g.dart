// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel()
  ..objectId = json['objectId'] as String?
  ..avatar = json['avatar'] == null ? null : Uri.parse(json['avatar'] as String)
  ..website = json['website'] as String? ?? ''
  ..name = json['name'] as String? ?? ''
  ..phone = json['phone'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..industries = (json['industries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..address = json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>);

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'avatar': instance.avatar?.toString(),
      'website': instance.website,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'industries': instance.industries,
      'address': instance.address,
    };
