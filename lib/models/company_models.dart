import 'package:json_annotation/json_annotation.dart';
import 'customer_models.dart';
part 'company_models.g.dart';

enum CompanyStatus { active, cancel }

extension CompanyStatusEx on CompanyStatus {
  String get label {
    switch (this) {
      case CompanyStatus.active:
        return 'Active';
      case CompanyStatus.cancel:
        return 'Cancel';
    }
  }
}

@JsonSerializable()
class CompanyModel {
  CompanyModel();

  String? objectId;
  Uri? avatar;
  @JsonKey(defaultValue: '')   String website = '';
  @JsonKey(defaultValue: [])   List<String> admins = [];
  @JsonKey(defaultValue: '')   String name = '';
  @JsonKey(defaultValue: '')   String phone = '';
  @JsonKey(defaultValue: '')   String email = '';
  @JsonKey(defaultValue: [])   List<String> industries = [];
  @JsonKey(defaultValue: CompanyStatus.active)
  CompanyStatus status = CompanyStatus.active;

  AddressModel? address;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  factory CompanyModel.fromMap(Map map) {
    Map address = map.remove('address');
    map['address'] = Map<String, dynamic>.from(address);
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return CompanyModel.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}