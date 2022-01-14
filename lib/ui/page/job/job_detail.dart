enum JobCategory {
  details,
  schedule,
  billing,
}

extension JobCategoryEx on JobCategory {
  String get label {
    switch (this) {
      case JobCategory.details:
        return "JOB DETAILS";
      case JobCategory.schedule:
        return "SCHEDULE";
      case JobCategory.billing:
        return "BILLING";
    }
  }
}
