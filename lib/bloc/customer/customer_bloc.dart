import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/api/api_service.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/customer_models.dart';
import '../bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final String tag = 'CustomerBloc';

  final BaseBloc _baseBloc;

  CustomerBloc(this._baseBloc) : super(CustomerState(customers: _baseBloc.state.customers));

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    if (event is SearchAddressEvent) {
      yield* searchAddress(event.input, event.countryCode ?? 'US');
    } else if (event is UpdateCustomerModelListEvent) {
      yield state.copyWith(customers: event.list);
    }
  }

  Stream<CustomerState> searchAddress(String input, String countryCode) async* {
    if (input.isEmpty) {
      yield state.copyWith(searchedAddressList: []);
      return;
    }
    if (input.length < 3) return;
    List<SearchAddressModel> list = await _fetchSuggestionAddresses(input, countryCode);
    yield state.copyWith(searchedAddressList: list);
  }

  Future<List<SearchAddressModel>> _fetchSuggestionAddresses(String text,
      String countryCode) async {
    if (text.length < 3) return [];
    dynamic response = await ApiService().googleApi(GoogleApi.AutoComplete, {
      'input': text,
      'radius': 5000,
      'sensor': true,
      'components': 'country:$countryCode'
    });
    if (response is Map) {
      List<dynamic> list = response['predictions'];
      return list.map((e) {
        SearchAddressModel addressModel =
        SearchAddressModel.fromJson(e['structured_formatting']);
        addressModel.placeId = e['place_id'];
        List<Map<String, dynamic>> terms = List<Map<String, dynamic>>.from(e['terms']);
        if (terms.isNotEmpty) {
          addressModel.state = terms[terms.length -2]['value'];
        }
        return addressModel;
      }).toList();
    }
    return [];
  }

  Future<List?> getLatLng(String placeId) async {
    dynamic response = await ApiService()
        .googleApi(GoogleApi.PlaceDetails, {'placeid': placeId});
    if (response is Map) {
      try {
        Map<String, dynamic> result =
        response['result']['geometry']['location'];
        double lat = result['lat'];
        double lng = result['lng'];
        String address = response['result']['formatted_address'];
        List<String> array = address.split(',');
        return [LatLng(lat, lng), address];
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}