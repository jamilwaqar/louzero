import 'package:equatable/equatable.dart';
import 'package:louzero/models/models.dart';


abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object> get props => [];
}

class BaseInitEvent extends BaseEvent {}

class UpdateSiteTemplateListEvent extends BaseEvent {
  final List<CTSiteProfile> list;
  const UpdateSiteTemplateListEvent(this.list);
}