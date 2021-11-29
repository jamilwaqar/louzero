export 'enum_ex.dart';

enum UserRole {
  admin,
  serviceTech,
  customer,
}

enum CTContactType {
  primary,
  billing,
  schedule,
  other
}

enum CustomerCategory {
  jobs,
  siteProfiles,
  contacts,
  pictures,
  notes,
  subAccounts
}

enum JobStatus {
  estimate,
  booked,
  invoiced,
  canceled,
}
