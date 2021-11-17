import 'package:equatable/equatable.dart';
import 'package:louzero/models/customer_models.dart';

class CustomerState extends Equatable {
  final bool isUpdating;
  final List<CustomerModel> customers;

  const CustomerState({
    this.isUpdating = false,
    this.customers = const [],
  });

  @override
  List<Object> get props => [
    isUpdating,
    customers,
  ];

  CustomerState copyWith({
    bool? isUpdating,
    List<CustomerModel>? customers
  }) {
    return CustomerState(
      isUpdating: isUpdating ?? this.isUpdating,
      customers: customers ?? this.customers,
    );
  }
}