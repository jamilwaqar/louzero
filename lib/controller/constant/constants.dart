import 'package:country_picker/country_picker.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';

abstract class Constant {
  static const String imgPrefixPath = 'assets/icons';
}

abstract class AppDefaultValue {
  static final country = Country(
      phoneCode: "1",
      countryCode: 'US',
      e164Sc: 1,
      geographic: true,
      level: 1,
      name: 'United States',
      example: '',
      displayName: "United States (US) [+1]",
      displayNameNoCountryCode: "United States (US)",
      e164Key: "1-US-0");
}

CustomerModel? tempCustomerModel;

/// Backendless Data Paths
abstract class BLPath {
  static const String user = "Users";
  static const String customer = "Customer";
  static const String customerSiteProfile = "CustomerSiteProfile";
  static const String siteProfileTemplate = "SiteProfileTemplate";
  static const String invites = "Invites";
  static const String company = "Company";
}

abstract class AppPlaceHolder {
  static const String user = "";
  static const String customer = "";
  static const String company = 'icon-company-logo';
}

/// GetStoreKeys
abstract class GSKey {
  static const String isAuthUser = "isAuthUser";
  static const String showGetStartedSiteProfile = "showGetStartedSiteProfile";
}

abstract class AppKey {
  static const String googleMapKey = 'AIzaSyDT3fQjqpPHJqEFu-40Qk0NP4OffWA0624';
}

abstract class GoogleApi {
  static const String autoComplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const String placeDetails =
      'https://maps.googleapis.com/maps/api/place/details/json';
  static const String reversGeocode =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const String direction =
      'https://maps.googleapis.com/maps/api/directions/json';
}