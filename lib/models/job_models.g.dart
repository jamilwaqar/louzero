// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      status: json['status'] as String,
      description: json['description'] as String,
      billingLineModel: BillingLineModel.fromJson(
          json['billingLineModel'] as Map<String, dynamic>),
      customerIds: (json['customerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    )
      ..objectId = json['objectId'] as String?
      ..ownerId = json['ownerId'] as String?;

Map<String, dynamic> _$JobModelToJson(JobModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('objectId', instance.objectId);
  writeNotNull('ownerId', instance.ownerId);
  val['status'] = instance.status;
  val['description'] = instance.description;
  val['customerIds'] = instance.customerIds;
  val['billingLineModel'] = instance.billingLineModel;
  return val;
}

BillingLineModel _$BillingLineModelFromJson(Map<String, dynamic> json) =>
    BillingLineModel(
      jobId: json['jobId'] as String?,
      items: json['items'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$BillingLineModelToJson(BillingLineModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('jobId', instance.jobId);
  val['items'] = instance.items;
  return val;
}
