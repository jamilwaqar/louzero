import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/controller/api/api_service.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';

class BaseController extends GetxController {

  final _authController = Get.find<AuthController>();

  final _isLoading = false.obs;
  final _companies = Rx<List<CompanyModel>>([]);
  final _customers = Rx<List<CustomerModel>>([]);
  final _jobs = Rx<List<JobModel>>([]);

  final _siteProfileTemplates = Rx<List<CTSiteProfile>>([]);
  final _activeCompany = Rx<CompanyModel?>(null);

  List<CompanyModel> get companies => _companies.value;
  set companies(List<CompanyModel> value) => _companies.value = value;

  List<CustomerModel> get customers => _customers.value;
  set customers(List<CustomerModel> value) => _customers.value = value;

  List<JobModel> get jobs => _jobs.value;
  set jobs(List<JobModel> value) => _jobs.value = value;

  List<CTSiteProfile> get siteProfileTemplates => _siteProfileTemplates.value;
  set siteProfileTemplates(List<CTSiteProfile> value) => _siteProfileTemplates.value = value;

  CompanyModel? get activeCompany => _activeCompany.value;
  List<CompanyUserModel>activeCompanyUsers = [];
  set activeCompany(CompanyModel? value) {
    _activeCompany.value = value;
    _updateCompanyUsers();
  }

  _updateCompanyUsers() async {
    activeCompanyUsers = [];
    if (activeCompany == null) return;
    dynamic res = await _fetchCompanyUsers(activeCompany!.objectId!);
    if (res is List<CompanyUserModel>) {
      activeCompanyUsers = res;
    }
  }

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  fetchInitialData() async {
    if (_authController.user.objectId == null) return;
    NavigationController().loading();
    /// Company
    var companyList = await _fetchCompanies();
    CompanyModel? companyModel;
    if (companyList is List) {
      try {
        companyModel = (companyList as List<CompanyModel>)
            .firstWhere(
                (com) => com.objectId == _authController.user.activeCompanyId);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      companies = companyList as List<CompanyModel>;
      activeCompany = companyModel;
    }
    /// Site Profile Template
    var templates = await _fetchSiteProfileTemplate();
    if (templates is List) {
      siteProfileTemplates = templates as List<CTSiteProfile>;
    }
    /// Customers
    var customerList = await _fetchCustomers();
    if (customerList is List) {
      customers = customerList as List<CustomerModel>;
    }

    /// Jobs
    var jobList = await _fetchJobs();
    if (jobList is List) {
      jobs = jobList as List<JobModel>;
    }
    NavigationController().loading(isLoading: false);
  }

  Future _fetchSiteProfileTemplate() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${_authController.user.objectId}'";
    List<CTSiteProfile> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.siteProfileTemplate)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CTSiteProfile.fromMap(e))
          .toList();
      if (kDebugMode) {
        print('Site Profile Templates: ${list.length}');
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future _fetchCompanies() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${_authController.user.objectId}'";
    List<CompanyModel> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.company)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CompanyModel.fromMap(e))
          .toList();
      if (kDebugMode) {
        print('Companies: ${list.length}');
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future _fetchCompanyUsers(String companyId) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "companyId = '$companyId'";
    List<CompanyUserModel> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.companyUser)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CompanyUserModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      if (kDebugMode) {
        print('Company Users: ${list.length}');
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future _fetchCustomers() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${_authController.user.objectId}'"..pageSize = 100;
    try {
      var response = await Backendless.data.of(BLPath.customer).find(queryBuilder);
      List<CustomerModel>list = List<Map>.from(response!).map((e) => CustomerModel.fromMap(e)).toList();
      if (kDebugMode) {
        print('Customers: ${list.length}');
      }
      return list;
    } catch (e) {
      return e.toString();
    }
  }

  Future _fetchJobs() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${_authController.user.objectId}'"..pageSize = 100;
    try {
      var response = await Backendless.data.of(BLPath.job).find(queryBuilder);
      List<JobModel>list = List<Map>.from(response!).map((e) => JobModel.fromJson(Map<String, dynamic>.from(e))).toList();
      if (kDebugMode) {
        print('Jobs: ${list.length}');
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print('Fetch Jobs Error: ${e.toString()}');
      }
      return e.toString();
    }
  }

  final searchedAddresses = Rx<List<SearchAddressModel>>([]);

  set searchedAddressList(List<SearchAddressModel> list) {
    searchedAddresses.value = list;
  }

  JobModel? jobModelById(String objectId) {
    try {
      return jobs.firstWhere((e) => e.objectId == objectId);
    } catch (e) {
      return null;
    }
  }

  CustomerModel? customerModelById(String objectId) {
    try {
      return customers.firstWhere((e) => e.objectId == objectId);
    } catch (e) {
      return null;
    }
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