import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/state/auth_state.dart';
import 'package:louzero/models/customer_models.dart';
import '../bloc.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final String tag = 'BaseBloc';


  BaseBloc() : super(const BaseState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is BaseInitEvent) {
      yield* _fetchInitialData();
    } else if (event is UpdateSiteTemplateListEvent) {
      yield state.copyWith(siteProfileTemplates: event.list);
    }
  }

  Stream<BaseState> _fetchInitialData() async* {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId = '${AuthStateManager.userModel.objectId}'";
    List<CTSiteProfile> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.siteProfileTemplate)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CTSiteProfile.fromMap(e))
          .toList();
      yield state.copyWith(siteProfileTemplates: list);
    } catch (e) {
      print(e.toString());
    }
  }
}