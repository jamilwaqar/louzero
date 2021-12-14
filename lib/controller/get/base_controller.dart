import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/api/api_service.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/customer_models.dart';

class BaseController extends GetxController {

  final searchedAddresses = Rx<List<SearchAddressModel>>([]);

  set searchedAddressList(List<SearchAddressModel> list) {
    searchedAddresses.value = list;
  }

  searchAddress(String input, String countryCode) async {
    if (input.isEmpty) {
      searchedAddressList = [];
      return;
    }
    if (input.length < 3) return;
    List<SearchAddressModel> list = await _fetchSuggestionAddresses(input, countryCode);
    searchedAddressList = list;
  }

  Future<List<SearchAddressModel>> _fetchSuggestionAddresses(String text,
      String countryCode) async {
    if (text.length < 3) return [];
    dynamic response = await ApiService().googleApi(GoogleApi.autoComplete, {
      'input': text,
      'radius': 1000 * 5000,
      'sensor': true,
      'components': 'country:$countryCode'
    });
    if (response is Map) {
      List<dynamic> list = response['predictions'];
      List<SearchAddressModel> list1 = list.map((e) {
        SearchAddressModel addressModel =
        SearchAddressModel.fromJson(e['structured_formatting']);
        addressModel.placeId = e['place_id'];
        List<Map<String, dynamic>> terms = List<Map<String, dynamic>>.from(e['terms']);
        if (terms.isNotEmpty) {
          addressModel.state = terms[terms.length -2]['value'];
        }
        return addressModel;
      }).toList();
      return list1;
    }
    return [];
  }

  Future<List?> getLatLng(String placeId) async {
    dynamic response = await ApiService()
        .googleApi(GoogleApi.placeDetails, {'placeid': placeId});
    if (response is Map) {
      try {
        Map<String, dynamic> result =
        response['result']['geometry']['location'];
        double lat = result['lat'];
        double lng = result['lng'];
        String address = response['result']['formatted_address'];
        return [LatLng(lat, lng), address];
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}