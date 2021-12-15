// import 'package:backendless_sdk/backendless_sdk.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:louzero/controller/constant/constants.dart';
// import 'package:louzero/controller/state/auth_manager.dart';
// import 'package:louzero/models/company_models.dart';
// import 'package:louzero/models/models.dart';
// import '../bloc.dart';
//
// class BaseBloc extends Bloc<BaseEvent, BaseState> {
//   final String tag = 'BaseBloc';
//
//   BaseBloc() : super(const BaseState());
//
//   @override
//   Stream<BaseState> mapEventToState(BaseEvent event) async* {
//     if (event is BaseInitEvent) {
//       yield* _fetchInitialData();
//     } else if (event is UpdateSiteTemplateListEvent) {
//       yield state.copyWith(siteProfileTemplates: event.list);
//     }
//   }
//
//   Stream<BaseState> _fetchInitialData() async* {
//     if (AuthManager.userModel == null) return;
//     /// Company
//     var companies = await _fetchCompanies();
//     CompanyModel? companyModel;
//
//     if (companies is List) {
//       try {
//         companyModel = (companies as List<CompanyModel>)
//             .firstWhere(
//                 (com) => com.objectId == AuthManager.userModel!.activeCompanyId);
//       } catch (e) {
//         print(e.toString());
//       }
//       yield state.copyWith(companies: companies as List<CompanyModel>, activeCompany: companyModel);
//     }
//     /// Site Profile Template
//     var templates = await _fetchSiteProfileTemplate();
//     if (templates is List) {
//       yield state.copyWith(siteProfileTemplates: templates as List<CTSiteProfile>);
//     }
//   }
//
//   Future _fetchSiteProfileTemplate() async {
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "ownerId = '${AuthManager.userModel!.objectId}'";
//     List<CTSiteProfile> list = [];
//     try {
//       var response = await Backendless.data
//           .of(BLPath.siteProfileTemplate)
//           .find(queryBuilder);
//       list = List<Map>.from(response!)
//           .map((e) => CTSiteProfile.fromMap(e))
//           .toList();
//       return list;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future _fetchCompanies() async {
//     DataQueryBuilder queryBuilder = DataQueryBuilder()
//       ..whereClause = "ownerId = '${AuthManager.userModel!.objectId}'";
//     List<CompanyModel> list = [];
//     try {
//       var response = await Backendless.data
//           .of(BLPath.company)
//           .find(queryBuilder);
//       list = List<Map>.from(response!)
//           .map((e) => CompanyModel.fromMap(e))
//           .toList();
//       return list;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }