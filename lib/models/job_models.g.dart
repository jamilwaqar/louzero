// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      status: json['status'] as String,
      description: json['description'] as String,
      customerIds: (json['customerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'status': instance.status,
      'description': instance.description,
      'customerIds': instance.customerIds,
    };
