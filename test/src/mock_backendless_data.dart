import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:mockito/mockito.dart';

class MockBLDataStore extends Mock implements IDataStore {
  // @override
  // Future save(entity) {
  //   Map<String, dynamic> data = _customerModel.toJson();
  //   data['serviceAddress'] = _customerModel.serviceAddress.toJson();
  //   data['billingAddress'] = _customerModel.billingAddress.toJson();
  //   data['customerContacts'] =
  //       _customerModel.customerContacts.map((e) => e.toJson()).toList();
  //   return Future.value(data);
  // }
}