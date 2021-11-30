import 'package:louzero/models/customer_models.dart';

abstract class Constant {
  static const String imgPrefixPath = 'assets/icons';
}
CustomerModel? tempCustomerModel;
/// Backendless Data Paths
abstract class BLPath {
  static const String customer = "Customer";
  static const String customerSiteProfile = "CustomerSiteProfile";
  static const String siteProfileTemplate = "SiteProfileTemplate";
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