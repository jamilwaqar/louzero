import 'package:json_annotation/json_annotation.dart';
part 'job_models.g.dart';

@JsonSerializable()
class JobModel {
  JobModel({
    required this.jobId,
    required this.status,
    required this.description,
    required this.jobType,
    this.customerId,
  });

  @JsonKey(includeIfNull: false)
  String? objectId;
  @JsonKey(includeIfNull: false)
  String? ownerId;
  @JsonKey(includeIfNull: false)
  int? created;
  @JsonKey(includeIfNull: false)
  int? updated;

  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(created!);

  DateTime? get updatedAt =>
      updated != null ? DateTime.fromMillisecondsSinceEpoch(updated!) : null;

  String jobType;
  String status;

  int jobId;
  String description;
  String? customerId;
  @JsonKey(defaultValue: [])
  List<BillingLineModel> billingLineModels = [];
  String? note;

  factory JobModel.fromMap(Map map) {
    List billingLineModels = map.remove('billingLineModels');
    map['billingLineModels'] =
        billingLineModels.map((e) => Map<String, dynamic>.from(e)).toList();
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return JobModel.fromJson(json);
  }

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}

@JsonSerializable()
class BillingLineModel {
  BillingLineModel(
      {required this.jobId,
      required this.productName,
      required this.quantity,
      required this.price,
      this.comment,
      });

  @JsonKey(includeIfNull: false)
  String? objectId;
  String jobId; // job ObjectId
  String productName;
  double quantity;
  double price;
  String? comment;
  @JsonKey(defaultValue: false)
  bool taxable = false;

  // Discount
  @JsonKey(defaultValue: false)
  bool addDiscount = false;
  String? discountDescription;

  @JsonKey(defaultValue: true)
  bool isPercentDiscount = true;
  @JsonKey(defaultValue: 0.0)
  double discountAmount = 0.0;

  String? inventoryId;

  factory BillingLineModel.fromJson(Map<String, dynamic> json) =>
      _$BillingLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillingLineModelToJson(this);
}
