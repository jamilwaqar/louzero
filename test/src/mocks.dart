import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'mock_backendless_data.dart';
import 'mock_user_service.dart';

final mockBLUserService = MockBLUserService();
final mockBLDataStore = MockBLDataStore();
final mockUser = MockUser();
final mockAddress = MockAddressModel();
final mockJob = MockJobModel();
final mockCustomer = MockCustomerModel();
final mockUserModel = MockUserModel();
final mockCompanyModel = MockCompanyModel();

final Map<String, dynamic> addressJson = {
  'street': '350 W 40th St',
  'city': 'New York',
  'state': 'New York',
  'suite': '111',
  'zip': '10018',
  'country': 'United State',
  'latitude': 40.7566193,
  'longitude': -73.9932827
};

final mockAddressModel = AddressModel(
    country: mockAddress.country,
    street: mockAddress.street,
    city: mockAddress.city,
    state: mockAddress.state,
    zip: mockAddress.zip)
  ..suite = ''
  ..latitude = 0
  ..longitude = 0;

final mockJobModel = JobModel(
    jobId: 9999,
    status: JobStatus.estimate,
    description: mockJob.description,
    jobType: mockJob.jobType)
  ..objectId = mockJob.objectId;

final mockCustomerModel = CustomerModel(
    companyName: mockCustomer.companyName,
    type: mockCustomer.type,
    serviceAddress: mockAddressModel,
    billingAddress: mockAddressModel)
  ..objectId = const Uuid().v4()
  ..ownerId = const Uuid().v4();

class MockUserModel extends Mock implements UserModel {
  @override
  String get fullName => 'Mark Austen';

  @override
  String get initials => 'MA';

  @override
  String get phone => '(714)1112222';

  @override
  String get email => 'test@gmail.com';

  @override
  AddressModel get addressModel => mockAddressModel;
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
  double get latitude => 40.7566193;

  @override
  double get longitude => -73.9932827;
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
  JobStatus get status => JobStatus.estimate;

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

class MockCustomerModel extends Mock implements CustomerModel {
  @override
  String get objectId => const Uuid().v4();

  @override
  String get companyName => 'companyName';

  @override
  String get type => 'Residential';

  @override
  AddressModel get serviceAddress => mockAddress;

  @override
  AddressModel get billingAddress => mockAddress;
}