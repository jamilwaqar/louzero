import 'package:json_annotation/json_annotation.dart';
part 'job_models.g.dart';

@JsonSerializable()
class JobModel {
  JobModel(
      {required this.status,
      required this.description,
      this.customerIds = const []});

  String status;
  String description;
  @JsonKey(defaultValue: []) List<String> customerIds;

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