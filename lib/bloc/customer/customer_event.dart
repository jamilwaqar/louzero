import 'package:equatable/equatable.dart';
import 'package:louzero/models/models.dart';


abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class InitCustomerEvent extends CustomerEvent {}

class SearchAddressEvent extends CustomerEvent {
  final String input;
  final String? countryCode;

  const SearchAddressEvent(this.input, {this.countryCode = 'US'});
}

class UpdateCustomerModelListEvent extends CustomerEvent {
  final List<CustomerModel> list;
  const UpdateCustomerModelListEvent(this.list);
}

class UpdateCustomerModelEvent extends CustomerEvent {
  final CustomerModel model;
  const UpdateCustomerModelEvent(this.model);
}

class FetchCustomerDetailsEvent extends CustomerEvent {
  final String customerId;
  const FetchCustomerDetailsEvent(this.customerId);
}