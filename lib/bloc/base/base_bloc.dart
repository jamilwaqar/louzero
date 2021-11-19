import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final String tag = 'BaseBloc';


  BaseBloc() : super(BaseState());

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {

  }
}