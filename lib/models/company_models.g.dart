// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..objectId = json['objectId'] as String?
      ..name = json['name'] as String? ?? ''
      ..phone = json['phone'] as String? ?? ''
      ..email = json['email'] as String? ?? ''
      ..industries = (json['industries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [];

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'industries': instance.industries,
      'address': instance.address,
    };
