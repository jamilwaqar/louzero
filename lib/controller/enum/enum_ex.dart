import 'package:louzero/controller/enum/models.dart';

extension CTContactTypeEx on CTContactType {
  String get name {
    switch (this) {
      case CTContactType.primary:
        return 'Primary Contact';
      case CTContactType.billing:
        return 'Billing Contact';
      case CTContactType.schedule:
        return 'Scheduling Contact';
    }
  }
}

extension CustomerCategoryEx on CustomerCategory {
  String get title {
    switch(this) {
      case CustomerCategory.jobs:
        return 'Jobs';
      case CustomerCategory.siteProfiles:
        return 'Site Profiles';
      case CustomerCategory.contacts:
        return 'Contacts';
      case CustomerCategory.pictures:
        return 'Pictures';
      case CustomerCategory.notes:
        return 'Customer Notes';
      case CustomerCategory.subAccounts:
        return 'Sub-Accounts';
    }
  }

  String get description {
    switch(this) {
      case CustomerCategory.jobs:
        return 'Track and view existing Jobs as well as create new ones';
      case CustomerCategory.siteProfiles:
        return 'Keep track of important information about this customer’s location';
      case CustomerCategory.contacts:
        return 'Manage primary, billing, and other contacts for this customer';
      case CustomerCategory.pictures:
        return 'Keep track of location photos, job photos, and more';
      case CustomerCategory.notes:
        return 'A place to keep notes for this customer that don’t fit anywhere else';
      case CustomerCategory.subAccounts:
        return 'Manage and create new sub-account for this customer';
    }
  }
}

extension CTSiteTemplateEx on CTSiteTemplate {
  String get title {
    switch(this) {
      case CTSiteTemplate.residential:
        return "Residential\nPool";
      case CTSiteTemplate.commercial:
        return "Commercial\nPool";
      case CTSiteTemplate.custom:
        return 'Custom';
    }
  }
}