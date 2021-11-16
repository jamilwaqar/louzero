import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import '../base_scaffold.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var optInEmail =
        'Yes, I would like to receive email updates about products & services, upcoming webinars, news and events from LOUzero.';
    var termsLabel = 'I have read and agreed to the Terms of Service';
    return BaseScaffold(
      child: AppCardCenter(
        child: Column(
          children: [
            Column(
              children: [
                const AppTextHeader('Complete Signup'),
                const AppTextBody(
                  'Fill in your information below to finish the signup process.',
                  mb: 20,
                ),
                AppInputText(
                  controller: _firstNameController,
                  label: 'First Name',
                  keyboardType: TextInputType.name,
                ),
                AppInputText(
                  controller: _lastNameController,
                  label: 'Last Name',
                  keyboardType: TextInputType.name,
                ),
                AppInputText(
                  controller: _passwordController,
                  label: 'Password (8 or more characters)',
                  password: true,
                ),
                AppCheckboxWithLabel(mb: 15, label: termsLabel),
                AppCheckboxWithLabel(
                  label: optInEmail,
                  checked: true,
                ),
                AppButton(
                  mt: 20,
                  label: 'Create Account',
                  onPressed: _onCompleteSignup,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onCompleteSignup() async {
    // Process Form
  }
}

class AppCheckboxWithLabel extends StatelessWidget {
  const AppCheckboxWithLabel({
    Key? key,
    this.label,
    this.onChanged,
    this.checked = false,
    this.mt = 0,
    this.mb = 10,
    this.pl = 0,
    this.pr = 0,
  }) : super(key: key);

  final bool checked;
  final Function(bool?)? onChanged;
  final String? label;
  final double mt;
  final double mb;
  final double pl;
  final double pr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: pl, right: pr),
      margin: EdgeInsets.only(top: mt, bottom: mb),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
                checkColor: Colors.white,
                value: checked,
                activeColor: AppColors.dark_1,
                onChanged: (val) {
                  onChanged != null ? onChanged!(val) : (val) {};
                }),
          ),
          Expanded(
            child: Visibility(
              visible: label != null,
              child: AppTextBody(
                label!,
                pl: 10,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
