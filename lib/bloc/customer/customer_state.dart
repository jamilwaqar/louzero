// import 'package:equatable/equatable.dart';
// import 'package:louzero/models/models.dart';
//
// class CustomerState extends Equatable {
//   final bool isUpdating;
//   final List<CustomerModel> customers;
//   final List<SearchAddressModel> searchedAddressList;
//   final bool stateFlag;
//
//   const CustomerState({
//     this.isUpdating = false,
//     this.customers = const [],
//     this.searchedAddressList = const [],
//     this.stateFlag = false,
//   });
//
//   @override
//   List<Object> get props => [
//     isUpdating,
//     customers,
//     searchedAddressList,
//     stateFlag,
//   ];
//
//   CustomerState copyWith({
//     bool? isUpdating,
//     List<CustomerModel>? customers,
//     List<SearchAddressModel>? searchedAddressList,
//     bool? stateFlag,
//   }) {
//     return CustomerState(
//       isUpdating: isUpdating ?? this.isUpdating,
//       customers: customers ?? this.customers,
//       searchedAddressList: searchedAddressList ?? this.searchedAddressList,
//       stateFlag: stateFlag ?? this.stateFlag,
//     );
//   }
// }