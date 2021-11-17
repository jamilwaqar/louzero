import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final String tag = 'CustomerBloc';

  final BaseBloc _baseBloc;

  CustomerBloc(this._baseBloc) : super(CustomerState(customers: _baseBloc.state.customers));

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {

  }
}