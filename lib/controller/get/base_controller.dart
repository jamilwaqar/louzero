import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/api/api_service.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';

class BaseController extends GetxController {

  final isUpdating = false.obs;

  final companies = Rx<List<CompanyModel>>([]);
  final customers = Rx<List<CustomerModel>>([]);
  final siteProfileTemplates = Rx<List<CTSiteProfile>>([]);
  final activeCompany = Rx<CompanyModel?>(null);

  fetchInitialData() async {
    if (AuthManager.userModel == null) return;
    /// Company
    var companyList = await _fetchCompanies();
    CompanyModel? companyModel;

    if (companyList is List) {
      try {
        companyModel = (companyList as List<CompanyModel>)
            .firstWhere(
                (com) => com.objectId == AuthManager.userModel!.activeCompanyId);
      } catch (e) {
        print(e.toString());
      }
      companies.value = companyList as List<CompanyModel>;
      activeCompany.value = companyModel;
    }
    /// Site Profile Template
    var templates = await _fetchSiteProfileTemplate();
    if (templates is List) {
      siteProfileTemplates.value = templates as List<CTSiteProfile>;
    }
  }

  Future _fetchSiteProfileTemplate() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${AuthManager.userModel!.objectId}'";
    List<CTSiteProfile> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.siteProfileTemplate)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CTSiteProfile.fromMap(e))
          .toList();
      return list;
    } catch (e) {
      print(e.toString());
    }
  }

  Future _fetchCompanies() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${AuthManager.userModel!.objectId}'";
    List<CompanyModel> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.company)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CompanyModel.fromMap(e))
          .toList();
      return list;
    } catch (e) {
      print(e.toString());
    }
  }

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