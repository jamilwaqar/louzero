// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CTSiteProfile _$CTSiteProfileFromJson(Map<String, dynamic> json) =>
    CTSiteProfile()
      ..template =
          $enumDecodeNullable(_$CTSiteTemplateEnumMap, json['template'])
      ..name = json['name'] as String? ?? ''
      ..profiles = json['profiles'] as Map<String, dynamic>? ?? {};

Map<String, dynamic> _$CTSiteProfileToJson(CTSiteProfile instance) =>
    <String, dynamic>{
      'template': _$CTSiteTemplateEnumMap[instance.template],
      'name': instance.name,
      'profiles': instance.profiles,
    };

const _$CTSiteTemplateEnumMap = {
  CTSiteTemplate.residential: 'residential',
  CTSiteTemplate.commercial: 'commercial',
  CTSiteTemplate.custom: 'custom',
};
