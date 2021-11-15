// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CTSiteProfile _$CTSiteProfileFromJson(Map<String, dynamic> json) =>
    CTSiteProfile(
      name: json['name'] as String,
      profiles: json['profiles'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$CTSiteProfileToJson(CTSiteProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profiles': instance.profiles,
    };
