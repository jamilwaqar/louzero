import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockUserModel extends Mock implements UserModel {
  @override
  String get fullName => 'Mark Austen';

  @override
  String get initials => 'MA';

  @override
  String get phone => '(714)1112222';

  @override
  String get email => 'test@gmail.com';
}

class MockAddressModel extends Mock implements AddressModel {
  @override
  String get country => 'United State';

  @override
  String get street => '350 W 40th St';

  @override
  String get city => 'New York';

  @override
  String get suite => '';

  @override
  String get state => 'New York';

  @override
  String get zip => '10018';

  @override
  double get latitude => 0.0;

  @override
  double get longitude => 0.0;
}

class MockCompanyModel extends Mock implements CompanyModel {
  @override
  String get name => 'Mark Company';

  @override
  CompanyStatus get status => CompanyStatus.active;
}

class MockJobModel extends Mock implements JobModel {
  @override
  String get objectId => const Uuid().v4();

  @override
  String get ownerId => const Uuid().v4();

  @override
  String get jobType => 'Repair';

  @override
  String get status => 'Estimate';

  @override
  int get jobId => 9999;

  @override
  String get description =>
      'Need to fix something important at this job. It’s pretty complex so be prepared for that complexity. ';

  @override
  String get customerId => const Uuid().v4();

  @override
  List<BillingLineModel> billingLineModels = [];

  @override
  List<ScheduleModel> scheduleModels = [];

  @override
  String get note => 'note';
}