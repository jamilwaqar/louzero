import 'package:json_annotation/json_annotation.dart';
part 'job_models.g.dart';

@JsonSerializable()
class JobModel {
  JobModel(
      {required this.status,
      required this.description,
      required this.billingLineModel,
      this.customerIds = const []});

  @JsonKey(includeIfNull: false) String? objectId;
  @JsonKey(includeIfNull: false) String? ownerId;
  String status;
  String description;
  @JsonKey(defaultValue: []) List<String> customerIds;
  BillingLineModel billingLineModel;

  factory JobModel.fromMap(Map map) {
    Map profiles = map.remove('profiles');
    map['profiles'] = Map<String, dynamic>.from(profiles);
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
      {this.jobId, this.items = const {}});


  @JsonKey(includeIfNull: false) String? jobId;
  Map<String, dynamic> items;

  factory BillingLineModel.fromMap(Map map) {
    Map profiles = map.remove('items');
    map['items'] = Map<String, dynamic>.from(profiles);
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return BillingLineModel.fromJson(json);
  }

  factory BillingLineModel.fromJson(Map<String, dynamic> json) =>
      _$BillingLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$BillingLineModelToJson(this);
}
