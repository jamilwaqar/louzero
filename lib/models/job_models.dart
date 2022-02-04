import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:uuid/uuid.dart';
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
  @JsonKey(defaultValue: [])
  List<ScheduleModel> scheduleModels = [];
  String? note;

  factory JobModel.fromMap(Map map) {
    List billingLineModels = map.remove('billingLineModels');
    map['billingLineModels'] =
        billingLineModels.map((e) => Map<String, dynamic>.from(e)).toList();
    List scheduleModels = map.remove('scheduleModels') ?? [];
    map['scheduleModels'] = scheduleModels.map((e) => Map<String, dynamic>.from(e)).toList();
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return JobModel.fromJson(json);
  }

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}

@JsonSerializable()
class BillingLineModel {
  BillingLineModel({
    required this.description,
    required this.jobId,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.objectId,
    this.note,
    this.addDiscount = false,
    this.taxable = false,
    this.isPercentDiscount = true,
    required this.discountAmount,
    this.discountDescription,
    this.inventoryId,
  });

  @JsonKey(includeIfNull: false)
  String? objectId;
  String jobId; // job ObjectId

  double quantity;
  double price;
  String description;
  String? note;
  double subtotal = 0;
  @JsonKey(defaultValue: false)
  bool taxable = false;

  // Discount
  @JsonKey(defaultValue: false)
  bool addDiscount = false;
  String? discountDescription;
  String? taxCodeName;
  @JsonKey(defaultValue: true)
  bool isPercentDiscount = true; /// % or $
  @JsonKey(defaultValue: 0.0)
  double discountAmount = 0.0;

  String? inventoryId;

  BillingLineModel clone() {
    return BillingLineModel(
        description: description,
        jobId: jobId,
        objectId: const Uuid().v4(),
        discountDescription: discountDescription,
        note: note,
        isPercentDiscount: isPercentDiscount,
        addDiscount: addDiscount,
        quantity: quantity,
        price: price,
        taxable: taxable,
        subtotal: subtotal,
        inventoryId: inventoryId,
        discountAmount: discountAmount);
  }

  factory BillingLineModel.fromJson(Map<String, dynamic> json) =>
      _$BillingLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillingLineModelToJson(this);
}

@JsonSerializable()
class ScheduleModel {
  ScheduleModel({
    required this.startTime,
    required this.endTime,
    this.note,
    required this.objectId,
    required this.personnelName,
    this.personnelAvatar,
    required this.personnelId,
    this.anyTimeVisit = false,
    this.complete = false,
  });

  String objectId;
  int startTime;
  int endTime;
  String? note;
  String personnelId;
  bool anyTimeVisit;
  bool complete;
  String personnelName;
  Uri? personnelAvatar;
  DateTime get start => DateTime.fromMillisecondsSinceEpoch(startTime);
  DateTime get end => DateTime.fromMillisecondsSinceEpoch(endTime);
  String get startEndTime {
    if (anyTimeVisit) return 'Any time today';
    return '${start.time} - ${end.time}';
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}