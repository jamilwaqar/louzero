import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/api/api_service.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/models/models.dart';
import '../bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final String tag = 'CustomerBloc';

  final BaseBloc _baseBloc;

  CustomerBloc(this._baseBloc) : super(CustomerState(customers: _baseBloc.state.customers));

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    if (event is InitCustomerEvent) {
      yield* _fetchCustomers();
    } else if (event is FetchCustomerDetailsEvent) {
      yield* _fetchSiteProfile(event.customerId);
    } else if (event is SearchAddressEvent) {
      yield* searchAddress(event.input, event.countryCode ?? 'US');
    } else if (event is UpdateCustomerModelListEvent) {
      yield state.copyWith(customers: event.list);
    } else if (event is UpdateCustomerModelEvent) {
      yield* _updateCustomerModel(event.model);
    }
  }

  Stream<CustomerState> _fetchCustomers() async* {
    NavigationController().loading(delay: 50);
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${AuthStateManager.userModel.objectId}'";
    var response = await Backendless.data.of(BLPath.customer).find(queryBuilder);
    List<CustomerModel>list = List<Map>.from(response!).map((e) => CustomerModel.fromMap(e)).toList();
    yield state.copyWith(customers: list);
    if (list.isNotEmpty) {
      tempCustomerModel = list[0];
      tempJobModels = [];
      JobModel jobModel = JobModel(
          status: "Repair",
          description:
              "Need to fix something imporant at this job. Maybe this request is very long? How long are these on average?");
      jobModel.customerIds = [tempCustomerModel!.objectId!];
      tempJobModels!.add(jobModel);
    }
    NavigationController().loading(isLoading: false);
  }

  Stream<CustomerState> _fetchSiteProfile(String customerId) async* {
    CustomerModel? model = customerModelById(customerId);
    if (model != null && model.siteProfiles.isNotEmpty) return;
    NavigationController().loading(delay: 50);
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "customerId = '$customerId'";
    List<CTSiteProfile> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.customerSiteProfile)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CTSiteProfile.fromMap(e))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    if (model != null) {
      model.siteProfiles = list;
      add(UpdateCustomerModelEvent(model));
    }
    NavigationController().loading(isLoading: false);
  }

  Stream<CustomerState> _updateCustomerModel(CustomerModel model) async* {
    List<CustomerModel> models = [... state.customers];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    yield state.copyWith(customers: models, stateFlag: !state.stateFlag);
  }

  CustomerModel? customerModelById(String customerId) {
    try {
      return state.customers.firstWhere((e) => e.objectId == customerId);
    } catch(e) {
      return null;
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
    dynamic response = await ApiService().googleApi(GoogleApi.autoComplete, {
      'input': text,
      'radius': 1000 * 5000,
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