import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_dropdown_multiple.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/list_state_names.dart';

class CompanyModel {
  String? name;
  String? email;
  String? website;
  String? phone;
  String? street;
  String? suite;
  String? country;
  String? city;
  String? state;
  String? zip;

  CompanyModel(
      {this.name,
      this.email,
      this.website,
      this.phone,
      this.street,
      this.suite,
      this.country,
      this.city,
      this.state,
      this.zip});
}

class AccountSetupCompany extends StatefulWidget {
  AccountSetupCompany({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountSetupCompany> createState() => _AccountSetupCompanyState();
}

class _AccountSetupCompanyState extends State<AccountSetupCompany> {
  final TextEditingController _controlTBD = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _model = CompanyModel();

  String? _validatePhone(String? value) {
    RegExp regex = RegExp('^(?:[+0]9)?[0-9]{10}\$');

    if (value != null && value.isEmpty) {
      return 'Phone Number is required';
    }

    if (value != null && !regex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }

  String? _validateName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Name is required';
    } else {
      return null;
    }
  }

  Widget inputPhone() => AppInputText(
        required: true,
        label: 'Phone Number',
        keyboardType: TextInputType.phone,
        onSaved: (val) {
          _model.phone = val;
        },
        validator: _validatePhone,
      );

  Widget inputCompany() => AppInputText(
        required: true,
        label: 'Company Name',
        onSaved: (val) {
          _model.name = val;
        },
        validator: _validateName,
      );

  Widget inputWebsite() => AppInputText(
        label: 'Website',
        onSaved: (val) {
          _model.website = val;
        },
      );

  Widget inputEmail() => AppInputText(
        label: 'Email Address',
        onSaved: (val) {
          _model.email = val;
        },
      );
  Widget inputCountry() => AppInputText(
        label: 'Country',
        onSaved: (val) {
          _model.country = val;
        },
      );
  Widget inputStreet() => AppInputText(
        label: 'Street',
        onSaved: (val) {
          _model.street = val;
        },
      );
  Widget inputSuite() => AppInputText(
        label: 'Suite',
        onSaved: (val) {
          _model.suite = val;
        },
      );
  Widget inputCity() => AppInputText(
        label: 'City',
        onSaved: (val) {
          _model.city = val;
        },
      );
  Widget inputState() => AppInputText(
        label: 'State',
        options: listStateNames,
        onSaved: (val) {
          _model.state = val;
        },
      );
  Widget inputZip() => AppInputText(
        label: 'Zip',
        onSaved: (val) {
          _model.zip = val;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppCard(
              children: [
                const AppTextHeader(
                  'Company Deets',
                  alignLeft: true,
                  icon: Icons.home_work_sharp,
                  size: 24,
                ),
                AppRowFlex(children: [
                  inputCompany(),
                  inputPhone(),
                ]),
                AppRowFlex(children: [
                  inputWebsite(),
                  inputEmail(),
                ]),
                const Divider(
                  color: AppColors.light_3,
                ),
                AppDropdownMultiple(
                  label: 'What Industries do you serve?',
                  controller: _controlTBD,
                ),
              ],
            ),
            AppCard(
              mt: 24,
              children: [
                const AppTextHeader(
                  'Company Address',
                  alignLeft: true,
                  icon: Icons.location_on,
                  size: 24,
                ),
                inputCountry(),
                inputStreet(),
                inputSuite(),
                AppRowFlex(flex: const [
                  2,
                  1,
                  1
                ], children: [
                  inputCountry(),
                  inputState(),
                  inputZip(),
                ])
              ],
            ),
            AppRowFlex(ml: 16, children: [
              AppButton(
                label: 'Submit',
                onPressed: () {
                  var isValid = _formKey.currentState?.validate();
                  if (isValid != null && isValid) {
                    _formKey.currentState?.save();
                    inspect(_model);
                  }
                },
              ),
            ])
          ],
        ));
  }
}
