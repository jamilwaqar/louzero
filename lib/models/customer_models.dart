import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:louzero/controller/enum/enums.dart';
part 'customer_models.g.dart';

@JsonSerializable()
class CustomerModel {
  CustomerModel(
      {required this.companyId,
      required this.name,
      required this.type,
      required this.serviceAddress,
      required this.billingAddress});

  @JsonKey(includeIfNull: false) String? objectId;
  @JsonKey(includeIfNull: false) String? ownerId;
  String name;
  String type;
  String? parentId;
  String companyId;
  AddressModel serviceAddress;
  AddressModel billingAddress;

  @JsonKey(defaultValue: [])
  List<CustomerContact> customerContacts = [];

  @JsonKey(defaultValue: [])
  List<CTSiteProfile> siteProfiles = [];
  
  String get fullServiceAddress => "${serviceAddress.street}, ${serviceAddress.city}, ${serviceAddress.state}";

  factory CustomerModel.fromMap(Map map) {
    Map serviceAddress = map.remove('serviceAddress');
    Map billingAddress = map.remove('billingAddress');
    List customerContacts = map.remove('customerContacts');
    map['serviceAddress'] = Map<String, dynamic>.from(serviceAddress);
    map['billingAddress'] = Map<String, dynamic>.from(billingAddress);
    map['customerContacts'] =
        customerContacts.map((e) => Map<String, dynamic>.from(e)).toList();
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return CustomerModel.fromJson(json);
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class CTSiteProfile {
  CTSiteProfile(
      {this.customerId, required this.name, this.profiles = const {}});

  String name;
  @JsonKey(includeIfNull: false) String? customerId;
  Map<String, dynamic> profiles;

  factory CTSiteProfile.fromMap(Map map) {
    Map profiles = map.remove('profiles');
    map['profiles'] = Map<String, dynamic>.from(profiles);
    Map<String, dynamic> json = Map<String, dynamic>.from(map);
    return CTSiteProfile.fromJson(json);
  }

  factory CTSiteProfile.fromJson(Map<String, dynamic> json) =>
      _$CTSiteProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CTSiteProfileToJson(this);
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

  @JsonKey(defaultValue: 0.0)
  double latitude = 0.0;
  @JsonKey(defaultValue: 0.0)
  double longitude = 0.0;

  bool get isValidLocation => latitude != 0 && longitude != 0;

  LatLng? get latLng {
    if (isValidLocation) {
      return LatLng(latitude, longitude);
    } else {
      return null;
    }
  }

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

  String get fullName => "$firstName $lastName";
  @JsonKey(defaultValue: []) List<CTContactType> types;

  factory CustomerContact.fromJson(Map<String, dynamic> json) =>
      _$CustomerContactFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerContactToJson(this);
}

@JsonSerializable()
class SearchAddressModel {
  SearchAddressModel();
  @JsonKey(defaultValue: '')                                  String placeId = '';
  @JsonKey(name: 'main_text', defaultValue: '')               String name = '';
  @JsonKey(name: 'secondary_text', defaultValue: '')          String description = '';
  @JsonKey(defaultValue: '')                                  String state = '';
  @JsonKey(defaultValue: 0.0)                                 double latitude = 0.0;
  @JsonKey(defaultValue: 0.0)                                 double longitude = 0.0;

  factory SearchAddressModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAddressModelToJson(this);
}