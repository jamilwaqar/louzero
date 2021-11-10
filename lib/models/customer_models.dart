import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/enum/enums.dart';
part 'customer_models.g.dart';

@JsonSerializable()
class CTSiteProfile {
  CTSiteProfile();

  CTSiteTemplate? template;
  @JsonKey(defaultValue: "")
  String name = "";
  @JsonKey(defaultValue: {})
  Map<String, dynamic> profiles = {};
}