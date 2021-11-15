import 'package:json_annotation/json_annotation.dart';
part 'customer_models.g.dart';

@JsonSerializable()
class CTSiteProfile {
  CTSiteProfile({required this.name, this.profiles = const {}});

  String name;
  Map<String, dynamic> profiles;

  factory CTSiteProfile.fromJson(Map<String, dynamic> json) => _$CTSiteProfileFromJson(json);
  Map<String, dynamic> toJson() => _$CTSiteProfileToJson(this);
}
