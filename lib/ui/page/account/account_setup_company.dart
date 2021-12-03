import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_divider.dart';
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
  const AccountSetupCompany({Key? key, this.onChange}) : super(key: key);

  final CompanyModel Function(CompanyModel)? onChange;

  @override
  State<AccountSetupCompany> createState() => _AccountSetupCompanyState();
}

class _AccountSetupCompanyState extends State<AccountSetupCompany> {
  final TextEditingController _controlTBD = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _model = CompanyModel();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppCard(
              children: [
                _headingDetails(),
                Row(
                  children: [
                    Expanded(
                      child: _inputCompany(),
                    ),
                    gapX(24),
                    Expanded(
                      child: _inputPhone(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _inputWebsite(),
                    ),
                    gapX(24),
                    Expanded(
                      child: _inputEmail(),
                    ),
                  ],
                ),
                const AppDivider(
                  mt: 16,
                  mb: 24,
                  color: AppColors.light_2,
                ),
                _inputTags(),
              ],
            ),
            AppCard(
              mt: 24,
              children: [
                _inputCountry(),
                _inputStreet(),
                _inputSuite(),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: _inputCity(),
                    ),
                    gapX(24),
                    Expanded(
                      flex: 3,
                      child: _inputState(),
                    ),
                    gapX(24),
                    Expanded(
                      flex: 2,
                      child: _inputZip(),
                    ),
                  ],
                ),
              ],
            ),
            AppRowFlex(ml: 16, children: [
              AppButton(
                label: 'Submit',
                onPressed: _submit,
              ),
            ])
          ],
        ));
  }

  void _submit() {
    var isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      if (widget.onChange != null) {
        widget.onChange!(_model);
      }
    }
  }

  // Validation:
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

  _headingAddress() => const AppTextHeader(
        'Company Address',
        alignLeft: true,
        icon: Icons.location_on,
        size: 24,
      );

  _headingDetails() => const AppTextHeader(
        'Company Details',
        alignLeft: true,
        icon: Icons.home_work_sharp,
        size: 24,
      );

  _inputPhone() => AppInputText(
        required: true,
        label: 'Phone Number',
        keyboardType: TextInputType.phone,
        validator: _validatePhone,
        onSaved: (val) {
          _model.phone = val;
        },
      );

  _inputCompany() => AppInputText(
        required: true,
        label: 'Company Name',
        validator: _validateName,
        onSaved: (val) {
          _model.name = val;
        },
      );

  _inputWebsite() => AppInputText(
        label: 'Website',
        onSaved: (val) {
          _model.website = val;
        },
      );

  _inputEmail() => AppInputText(
        label: 'Email Address',
        required: true,
        onSaved: (val) {
          _model.email = val;
        },
      );
  _inputTags() => AppInputText(
      label: 'What Industries do you Serve?',
      onSaved: (val) {
        _model.email = val;
      },
      mb: 0);
  _inputCountry() => AppInputText(
        label: 'Country',
        onSaved: (val) {
          _model.country = val;
        },
      );
  _inputStreet() => AppInputText(
        label: 'Street',
        onSaved: (val) {
          _model.street = val;
        },
      );
  _inputSuite() => AppInputText(
        label: 'Suite',
        onSaved: (val) {
          _model.suite = val;
        },
      );
  _inputCity() => AppInputText(
        label: 'City',
        onSaved: (val) {
          _model.city = val;
        },
      );
  _inputState() => AppInputText(
        label: 'State',
        options: listStateNames,
        onSaved: (val) {
          _model.state = val;
        },
      );
  _inputZip() => AppInputText(
        label: 'Zip',
        onSaved: (val) {
          _model.zip = val;
        },
      );

  // Utility Functions
  Widget gapX(double gap) {
    return SizedBox(width: gap);
  }

  Widget gapY(double gap) {
    return SizedBox(height: gap);
  }
}

class ExpandedRow extends StatelessWidget {
  const ExpandedRow({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = children.asMap().entries.map((entry) {
      return Expanded(flex: 1, child: entry.value);
    }).toList();

    // for (var i = 0; i < items.length; i++) {
    //   items.insert(i + 1, SizedBox(width: 24));
    // }

    return Row(
      children: [...items],
    );
  }
}
