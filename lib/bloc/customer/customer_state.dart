import 'package:equatable/equatable.dart';
import 'package:louzero/models/customer_models.dart';

class CustomerState extends Equatable {
  final bool isUpdating;
  final List<CustomerModel> customers;
  final List<SearchAddressModel> searchedAddressList;

  const CustomerState({
    this.isUpdating = false,
    this.customers = const [],
    this.searchedAddressList = const [],
  });

  @override
  List<Object> get props => [
    isUpdating,
    customers,
    searchedAddressList,
  ];

  CustomerState copyWith({
    bool? isUpdating,
    List<CustomerModel>? customers,
    List<SearchAddressModel>? searchedAddressList,
  }) {
    return CustomerState(
      isUpdating: isUpdating ?? this.isUpdating,
      customers: customers ?? this.customers,
      searchedAddressList: searchedAddressList ?? this.searchedAddressList,
    );
  }
}