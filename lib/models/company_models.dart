import 'package:json_annotation/json_annotation.dart';
import 'customer_models.dart';
part 'company_models.g.dart';

@JsonSerializable()
class CompanyModel {
  CompanyModel();

  String? objectId;
  @JsonKey(defaultValue: '')   String website = '';
  @JsonKey(defaultValue: '')   String name = '';
  @JsonKey(defaultValue: '')   String phone = '';
  @JsonKey(defaultValue: '')   String email = '';
  @JsonKey(defaultValue: [])   List<String> industries = [];

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