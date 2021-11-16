import 'package:louzero/models/customer_models.dart';

abstract class Constant {
  static const String imgPrefixPath = 'assets/icons';
  /// Site Template Mock
  static List<CTSiteProfile> siteTemplates = [
    CTSiteProfile(name: 'Residential Pool', profiles: {
      'Pool Shape': null,
      'Gallons' : null,
      'Chemical System' : null
    }),
    CTSiteProfile(name: 'Commercial Pool', profiles: {
      'Pool Shape': null,
      'Gallons' : null,
      'Chemical System' : null,
    }),
    CTSiteProfile(name: 'Test Pool', profiles: {
      'Pool Shape': null,
      'Gallons' : null,
      'Chemical System' : null
    }),
  ];
}

abstract class BPath {
  static const String customer = "Customer";
}

abstract class AppKey {
  static const String googleMapKey = 'AIzaSyDT3fQjqpPHJqEFu-40Qk0NP4OffWA0624';
}