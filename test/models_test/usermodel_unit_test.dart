import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/models/user_models.dart';
import '../src/mocks.dart';

void main() {

  setUp(() {});

  tearDown(() {});

  test("UserModel test", () {
    Map<String, dynamic> json = {
      'email': 'test@gmail.com',
      'firstname': 'Mark',
      'lastname': 'Austen',
      'phone': '(714)1112222',
      'activeCompanyId': '12345'
    };

    UserModel user = UserModel.fromMap(json);
    expect(user.firstname, 'Mark');
    expect(user.lastname, 'Austen');
    expect(user.phone, '(714)1112222');
    expect(user.email, 'test@gmail.com');
    expect(user.activeCompanyId, '12345');
    expect(user.fullName, 'Mark Austen');
    expect(user.initials, 'MA');
    expect(user.addressModel, isNull);

    json['addressModel'] = addressJson;
    user = UserModel.fromMap(json);

    expect(user.addressModel, isNotNull);
    expect(user.addressModel?.country, 'United State');
    expect(user.addressModel?.city, 'New York');
    expect(user.addressModel?.state, 'New York');
    expect(user.addressModel?.zip, '10018');
    expect(user.addressModel?.suite, '111');
    expect(user.addressModel?.street, '350 W 40th St');
    expect(user.addressModel?.latitude, 40.7566193);
    expect(user.addressModel?.longitude, -73.9932827);
    expect(user.addressModel?.latLng, const LatLng(40.7566193, -73.9932827));
    expect(user.addressModel?.isValidLocation, true);
    expect(user.addressModel?.fullAddress, "350 W 40th St, New York, New York");

    Map<String, dynamic> data = user.toJson();
    expect(data, isNotNull);
    expect(data, isNotEmpty);
    expect(data['phone'], '(714)1112222');
    expect(data['email'], 'test@gmail.com');
    expect(data['firstname'], 'Mark');
    expect(data['lastname'], 'Austen');
    expect(data['addressModel'], isNotNull);
  });
}
