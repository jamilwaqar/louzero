import 'package:equatable/equatable.dart';
import 'package:louzero/models/customer_models.dart';

class BaseState extends Equatable {
  final bool isUpdating;
  final List<CustomerModel> customers;

  const BaseState({
    this.isUpdating = false,
    this.customers = const [],
  });

  @override
  List<Object> get props => [
    isUpdating,
    customers,
  ];

  BaseState copyWith({
    bool? isUpdating,
    List<CustomerModel>? customers
  }) {
    return BaseState(
      isUpdating: isUpdating ?? this.isUpdating,
      customers: customers ?? this.customers,
    );
  }
}