import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/models/company_models.dart';
import 'package:uuid/uuid.dart';
import '../src/mocks.dart';

void main() {

  setUp(() {});

  tearDown(() {});

  test("CompanyModel test", () {
    String objectId = const Uuid().v4();
    String ownerId = const Uuid().v4();
    Map<String, dynamic> json = {
      'objectId': objectId,
      'ownerId': ownerId,
      'website': 'https://www.google.com/',
      'phone': '(714)1112222',
      'email': 'test@gmail.com',
      'status': 'active',
      'industries': [],
      'address': addressJson
    };

    final company = CompanyModel.fromMap(json);
    expect(company.objectId, objectId);
    expect(company.ownerId, ownerId);
    expect(company.website, 'https://www.google.com/');
    expect(company.phone, '(714)1112222');
    expect(company.status, CompanyStatus.active);
    expect(company.email, 'test@gmail.com');
    expect(company.industries, isEmpty);
    expect(company.address, isNotNull);
    expect(company.address?.country, 'United State');
  });
}
