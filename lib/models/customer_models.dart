import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/enum/enums.dart';

part 'customer_models.g.dart';

@JsonSerializable()
class CTSiteProfile {
  CTSiteProfile({required this.name, this.profiles = const {}});

  String name;
  Map<String, dynamic> profiles;

  factory CTSiteProfile.fromJson(Map<String, dynamic> json) =>
      _$CTSiteProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CTSiteProfileToJson(this);
}

@JsonSerializable()
class CustomerModel {
  CustomerModel(
      {required this.id,
      required this.userId,
      required this.companyId,
      required this.name,
      required this.type,
      required this.serviceAddress,
      required this.billingAddress});

  String id;
  String userId;
  String name;
  String type;
  String? parentId;
  String companyId;
  AddressModel serviceAddress;
  AddressModel billingAddress;

  @JsonKey(defaultValue: [])
  List<CustomerContact> customerContacts = [];

  @JsonKey(defaultValue: 0.0)
  double latitude = 0.0;
  @JsonKey(defaultValue: 0.0)
  double longitude = 0.0;

  int? createdAt;
  int? updatedAt;

  bool get isValidLocation => latitude != 0 && longitude != 0;

  LatLng? get latLng {
    if (isValidLocation) {
      return LatLng(latitude, longitude);
    } else {
      return null;
    }
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  AddressModel(
      {required this.country,
      required this.street,
      required this.city,
      required this.state,
      required this.zip});

  String country;
  String street;
  String city;
  String state;
  String zip;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable()
class CustomerContact {
  CustomerContact(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.role,
      this.types = const [],
      });

  String firstName;
  String lastName;
  String email;
  String phone;
  String role;
  @JsonKey(defaultValue: []) List<CTContactType> types;

  factory CustomerContact.fromJson(Map<String, dynamic> json) =>
      _$CustomerContactFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerContactToJson(this);
}
