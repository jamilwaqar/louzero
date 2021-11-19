import 'package:equatable/equatable.dart';
import 'package:louzero/models/customer_models.dart';


abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class SearchAddressEvent extends CustomerEvent {
  final String input;
  final String? countryCode;

  const SearchAddressEvent(this.input, {this.countryCode = 'US'});
}

class UpdateCustomerModelListEvent extends CustomerEvent {
  final List<CustomerModel> list;
  const UpdateCustomerModelListEvent(this.list);
}