import 'package:equatable/equatable.dart';
import 'package:louzero/models/customer_models.dart';

class BaseState extends Equatable {
  final bool isUpdating;
  final List<CustomerModel> customers;
  final List<CTSiteProfile> siteProfileTemplates;

  const BaseState({
    this.isUpdating = false,
    this.customers = const [],
    this.siteProfileTemplates = const [],
  });

  @override
  List<Object> get props => [
    isUpdating,
    customers,
    siteProfileTemplates,
  ];

  BaseState copyWith({
    bool? isUpdating,
    List<CustomerModel>? customers,
    List<CTSiteProfile>? siteProfileTemplates
  }) {
    return BaseState(
      isUpdating: isUpdating ?? this.isUpdating,
      customers: customers ?? this.customers,
      siteProfileTemplates: siteProfileTemplates ?? this.siteProfileTemplates,
    );
  }
}