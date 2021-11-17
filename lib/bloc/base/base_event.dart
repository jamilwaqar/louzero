import 'package:equatable/equatable.dart';


abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object> get props => [];
}

class BaseInitEvent extends BaseEvent {}