import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/customer_models.dart';

import 'app_divider.dart';

class AppCustomerInfo extends StatelessWidget {
  final AddressModel address;
  final CustomerContact contact;
  final String headerAddress;
  final String headerContact;

  const AppCustomerInfo(
      {required this.address,
      required this.contact,
      this.headerAddress = 'Billing Address:',
      this.headerContact = "Primary Contact:",
      Key? key})
      : super(key: key);

  String get nameAndRole {
    return "${contact.firstName} ${contact.lastName} - ${contact.role}";
  }

  String get fullAddress {
    return " ${address.street} ${address.city},  ${address.state}  ${address.zip}";
  }

  String get cityStateZip {
    return "${address.city},  ${address.state}  ${address.zip}";
  }

  Widget _txt(String text, {color = AppColors.secondary_20}) {
    return Text(text, style: AppStyles.bodyLarge.copyWith(color: color));
  }

  Widget _hdr(String text, {color = AppColors.secondary_20}) {
    return Text(text.toUpperCase(),
        style: AppStyles.headerSmallCaps.copyWith(color: color));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const AppDivider(mt: 0, mb: 24),
        _hdr(headerContact),
        const SizedBox(height: 8),
        _txt(nameAndRole),
        _txt(contact.email, color: const Color(0xFF86421A)),
        _txt(contact.phone),
        const SizedBox(height: 24),
        _hdr(headerAddress),
        const SizedBox(height: 8),
        _txt(address.street),
        _txt(cityStateZip),
        _txt(address.country),
      ],
    );
  }
}
