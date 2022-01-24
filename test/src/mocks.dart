import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:mockito/mockito.dart';

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

class MockCompanyModel extends Mock implements CompanyModel {
  @override
  String get name => 'Mark Company';

  @override
  CompanyStatus get status => CompanyStatus.active;
}