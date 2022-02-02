import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/models/customer_models.dart';

import '../src/mocks.dart';

void main() {

  setUp(() {});

  tearDown(() {});

  test('AddressModel Test', () {
    AddressModel address = AddressModel.fromJson(addressJson);
    expect(address.country, 'United State');
    expect(address.city, 'New York');
    expect(address.state, 'New York');
    expect(address.zip, '10018');
    expect(address.suite, '111');
    expect(address.street, '350 W 40th St');
    expect(address.latitude, 40.7566193);
    expect(address.longitude, -73.9932827);
    expect(address.latLng, const LatLng(40.7566193, -73.9932827));
    expect(address.isValidLocation, true);
    expect(address.fullAddress, "350 W 40th St, New York, New York");

    addressJson['latitude'] = 0.0;
    addressJson['longitude'] = 0.0;
    address = AddressModel.fromJson(addressJson);
    expect(address.isValidLocation, false);
  });
}
