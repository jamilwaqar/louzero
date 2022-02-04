import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'customer_models.dart';
import 'package:louzero/common/app_step_progress.dart';

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

enum UserStatus { active, inactive, invited }
enum UserRole { owner, admin, user }

@JsonSerializable()
class CompanyModel {
  CompanyModel();

  String? objectId;
  String? ownerId;
  Uri? avatar;
  @JsonKey(defaultValue: '')   String website = '';
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

@JsonSerializable()
class CompanyUserModel {
  CompanyUserModel({
    required this.companyId,
    required this.userId,
    required this.userName,
    this.avatar,
    this.invited,
    this.accepted,
    required this.status,
    required this.role,
  });

  String companyId;
  String userId;
  int? invited;
  int? accepted;
  String userName;
  Uri? avatar;
  UserStatus status;
  UserRole role;

  factory CompanyUserModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyUserModelToJson(this);
}

class ListItem {
  String? title;
  String? subtitle;

  ListItem({this.title, this.subtitle});
}

class AccountSetupModel {
  static List<StepProgressItem> stepItems = [
    StepProgressItem(
      label: 'My Company',
      title: 'To start, let\'s get some basic info.',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Customer Types',
      title: 'What types of customers do you have?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Job Types',
      title: 'What types of jobs do you do?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Done!',
      title: 'You’re all set, (username)!',
      subtitle: 'You can always manage these later in Settings.',
    ),
  ];

  static final List<ListItem> nextStepItems = [
    ListItem(
      title: 'Set up Site Profile Templates',
      subtitle:
      'Keep track of important information about your customer’s location.',
    ),
    ListItem(
      title: 'Set up your Inventory',
      subtitle:
      'Enable quicker billing by defining your common SKUs for quicker billing.   ',
    ),
    ListItem(
      title: 'Set up Users',
      subtitle: 'Invite others to join your team.',
    ),
  ];

  static const setupCompanyText =
      'Customer Types allow for categorization of customers. Common options are residential and commercial. This categorization will be helpful in reporting on performance.';
  static const setupJobsText =
      'Save time by profiling your common job types. Think about repairs, sales and recurring services. Later, you can build out full templates for each job type in Settings.';
  static const setupCompleteText =
      'There are more settings you can adjust for your company but they aren’t critical to getting started with LOUzero. If you choose to wait, you can find these and more via the Settings page at any time. ';
}
