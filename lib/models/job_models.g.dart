// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
      jobId: json['jobId'] as int,
      status: json['status'] as String,
      description: json['description'] as String,
      jobType: json['jobType'] as String,
      customerId: json['customerId'] as String?,
    )
      ..objectId = json['objectId'] as String?
      ..ownerId = json['ownerId'] as String?
      ..created = json['created'] as int?
      ..updated = json['updated'] as int?
      ..billingLineModels = (json['billingLineModels'] as List<dynamic>?)
              ?.map((e) => BillingLineModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []
      ..note = json['note'] as String?;

Map<String, dynamic> _$JobModelToJson(JobModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('objectId', instance.objectId);
  writeNotNull('ownerId', instance.ownerId);
  writeNotNull('created', instance.created);
  writeNotNull('updated', instance.updated);
  val['jobType'] = instance.jobType;
  val['status'] = instance.status;
  val['jobId'] = instance.jobId;
  val['description'] = instance.description;
  val['customerId'] = instance.customerId;
  val['billingLineModels'] = instance.billingLineModels;
  val['note'] = instance.note;
  return val;
}

BillingLineModel _$BillingLineModelFromJson(Map<String, dynamic> json) =>
    BillingLineModel(
      description: json['description'] as String,
      jobId: json['jobId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      objectId: json['objectId'] as String?,
      note: json['note'] as String?,
      addDiscount: json['addDiscount'] as bool? ?? false,
      taxable: json['taxable'] as bool? ?? false,
      isPercentDiscount: json['isPercentDiscount'] as bool? ?? true,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      discountDescription: json['discountDescription'] as String?,
      inventoryId: json['inventoryId'] as String?,
    );

Map<String, dynamic> _$BillingLineModelToJson(BillingLineModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('objectId', instance.objectId);
  val['jobId'] = instance.jobId;
  val['quantity'] = instance.quantity;
  val['price'] = instance.price;
  val['description'] = instance.description;
  val['note'] = instance.note;
  val['subtotal'] = instance.subtotal;
  val['taxable'] = instance.taxable;
  val['addDiscount'] = instance.addDiscount;
  val['discountDescription'] = instance.discountDescription;
  val['isPercentDiscount'] = instance.isPercentDiscount;
  val['discountAmount'] = instance.discountAmount;
  val['inventoryId'] = instance.inventoryId;
  return val;
}
