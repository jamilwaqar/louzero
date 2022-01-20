import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'customer_models.dart';
part 'company_models.g.dart';

enum CompanyStatus { active, cancel }

extension CompanyStatusEx on CompanyStatus {
  String get label {
    switch (this) {
      case CompanyStatus.active:
        return 'Active';
      case CompanyStatus.cancel:
        return 'Cancelled';
    }
  }

  Color get labelColor {
    switch(this) {
      case CompanyStatus.active:
        return AppColors.secondary_50;
      case CompanyStatus.cancel:
        return AppColors.secondary_80;
    }
  }

  Color get color {
    switch(this) {
      case CompanyStatus.active:
        return AppColors.accent_1;
      case CompanyStatus.cancel:
        return AppColors.error_50;
    }
  }
}

@JsonSerializable()
class CompanyModel {
  CompanyModel();

  String? objectId;
  String? ownerId;
  Uri? avatar;
  @JsonKey(defaultValue: '')   String website = '';
  @JsonKey(defaultValue: [])   List<String> admins = [];
  @JsonKey(defaultValue: [])   List<String> users = [];
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