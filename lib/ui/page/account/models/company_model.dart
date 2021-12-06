import 'package:louzero/common/app_step_progress.dart';

class ListItem {
  String? title;
  String? subtitle;

  ListItem({this.title, this.subtitle});
}

class CompanyModel {
  String? name;
  String? email;
  String? website;
  String? phone;
  String? street;
  String? suite;
  String? country;
  String? city;
  String? state;
  String? zip;

  CompanyModel(
      {this.name,
      this.email,
      this.website,
      this.phone,
      this.street,
      this.suite,
      this.country,
      this.city,
      this.state,
      this.zip});
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
