import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:uuid/uuid.dart';
import '../src/mocks.dart';

void main() {

  setUp(() {});

  tearDown(() {});

  Map<String, dynamic> contactJson = {
    'email': 'test@gmail.com',
    'firstName': 'Mark',
    'lastName': 'Austen',
    'phone': '(714)1112222',
    'role': 'Owner'
  };

  test('ContactModel test', () {
    final contact = CustomerContact.fromJson(contactJson);
    expect(contact.email, 'test@gmail.com');
    expect(contact.firstName, 'Mark');
    expect(contact.lastName, 'Austen');
    expect(contact.fullName, 'Mark Austen');
    expect(contact.phone, '(714)1112222');
    expect(contact.role, 'Owner');
  });

  test("CustomerModel test", () {
    String objectId = const Uuid().v4();
    Map<String, dynamic> json = {
      'objectId': objectId,
      'companyName': 'companyName',
      'type': 'Residential',
      'serviceAddress': addressJson,
      'billingAddress': addressJson,
      'customerContacts' : [contactJson]
    };

    final customer = CustomerModel.fromMap(json);
    expect(customer.objectId, objectId);
    expect(customer.companyName, 'companyName');
    expect(customer.type, 'Residential');
    expect(customer.serviceAddress, isNotNull);
    expect(customer.serviceAddress.country, 'United State');
    expect(customer.customerContacts, isNotNull);
    expect(customer.customerContacts, isNotEmpty);
    expect(customer.customerContacts.length, 1);
    expect(customer.customerContacts.first.email, 'test@gmail.com');
    expect(customer.customerContacts.first.firstName, 'Mark');
    expect(customer.customerContacts.first.lastName, 'Austen');
  });
}
