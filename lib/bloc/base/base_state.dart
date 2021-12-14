import 'package:equatable/equatable.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';

class BaseState extends Equatable {
  final bool isUpdating;
  final List<CompanyModel> companies;
  final List<CustomerModel> customers;
  final List<CTSiteProfile> siteProfileTemplates;
  final CompanyModel? activeCompany;

  const BaseState({
    this.isUpdating = false,
    this.companies = const [],
    this.customers = const [],
    this.siteProfileTemplates = const [],
    this.activeCompany
  });

  @override
  List<Object?> get props => [
    isUpdating,
    companies,
    customers,
    siteProfileTemplates,
    activeCompany
  ];

  BaseState copyWith({
    bool? isUpdating,
    List<CompanyModel>? companies,
    List<CustomerModel>? customers,
    List<CTSiteProfile>? siteProfileTemplates,
    CompanyModel? activeCompany,
  }) {
    return BaseState(
      isUpdating: isUpdating ?? this.isUpdating,
      companies: companies ?? this.companies,
      customers: customers ?? this.customers,
      siteProfileTemplates: siteProfileTemplates ?? this.siteProfileTemplates,
      activeCompany: activeCompany ?? this.activeCompany,
    );
  }
}