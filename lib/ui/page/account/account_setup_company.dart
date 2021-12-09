import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/list_state_names.dart';
import 'models/company_model.dart';

class AccountSetupCompany extends StatefulWidget {
  const AccountSetupCompany({
    Key? key,
    required this.data,
    this.onChange,
  }) : super(key: key);

  final void Function(CompanyModel)? onChange;
  final CompanyModel data;

  @override
  State<AccountSetupCompany> createState() => _AccountSetupCompanyState();
}

class _AccountSetupCompanyState extends State<AccountSetupCompany> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppCard(
              children: [
                const AppTextHeader(
                  'Company Details',
                  alignLeft: true,
                  icon: Icons.home_work_sharp,
                  size: 24,
                ),
                Row(
                  children: [
                    expand(_companyName()),
                    gapX(24),
                    expand(_phone())
                  ],
                ),
                Row(
                  children: [
                    expand(_email()),
                    gapX(24),
                    expand(_website()),
                  ],
                ),
                const AppDivider(
                  mt: 16,
                  mb: 24,
                  color: AppColors.light_2,
                ),
                _tags(),
              ],
            ),
            AppCard(
              children: [
                const AppTextHeader(
                  'Company Address',
                  alignLeft: true,
                  icon: Icons.location_on,
                  size: 24,
                ),
                _country(),
                _street(),
                _suite(),
                Row(
                  children: [
                    expand(_city(), 4),
                    gapX(24),
                    expand(_state(), 3),
                    gapX(24),
                    expand(_zip(), 2),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                AppButton(
                  ml: 24,
                  mb: 64,
                  label: 'Save & Continue',
                  onPressed: _submit,
                ),
              ],
            ),
          ],
        ));
  }

  Widget expand(Widget child, [flex = 1]) {
    return Expanded(child: child, flex: flex);
  }

  void _submit() {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      if (widget.onChange != null) widget.onChange!(widget.data);
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

  _phone() => AppInputText(
        required: true,
        label: 'Phone Number',
        keyboardType: TextInputType.phone,
        validator: _validatePhone,
        onSaved: (val) {
          widget.data.phone = val;
        },
      );

  _companyName() => AppInputText(
        required: true,
        label: 'Company Name',
        validator: _validateName,
        onSaved: (val) {
          widget.data.name = val;
        },
      );

  _website() => AppInputText(
        label: 'Website',
        onSaved: (val) {
          widget.data.website = val;
        },
      );

  _email() => AppInputText(
        label: 'Email Address',
        required: true,
        onSaved: (val) {
          widget.data.email = val;
        },
      );
  _tags() => AppInputText(
      label: 'What Industries do you Serve?',
      onSaved: (val) {
        widget.data.email = val;
      },
      mb: 0);
  _country() => AppInputText(
        label: 'Country',
        onSaved: (val) {
          widget.data.country = val;
        },
      );
  _street() => AppInputText(
        label: 'Street',
        onSaved: (val) {
          widget.data.street = val;
        },
      );
  _suite() => AppInputText(
        label: 'Suite',
        onSaved: (val) {
          widget.data.suite = val;
        },
      );
  _city() => AppInputText(
        label: 'City',
        onSaved: (val) {
          widget.data.city = val;
        },
      );
  _state() => AppInputText(
        label: 'State',
        options: listStateNames,
        onSaved: (val) {
          widget.data.state = val;
        },
      );
  _zip() => AppInputText(
        label: 'Zip',
        onSaved: (val) {
          widget.data.zip = val;
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
