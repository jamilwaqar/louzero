import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_checkbox.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';
import '../base_scaffold.dart';

class CompletePage extends StatefulWidget {
  final String email;
  const CompletePage(this.email, {Key? key}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailSelected = true;
  bool _termsSelected = false;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCardCenter(
            child: Column(
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
                AppCheckbox(
                  mb: 15,
                  label: termsLabel,
                  checked: _termsSelected,
                  onChanged: (val) {
                    setState(() {
                      _termsSelected = val!;
                    });
                  },
                ),
                AppCheckbox(
                  label: optInEmail,
                  checked: _emailSelected,
                  onChanged: (val) {
                    setState(() {
                      _emailSelected = val!;
                    });
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  label: 'Create Account',
                  onPressed: _completeSignup,
                  wide: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _completeSignup() async {
    NavigationController().loading();
    var res = await AuthAPI().signup(widget.email, _passwordController.text);
    if (res is String) {
      NavigationController().loading(isLoading: false);
      WarningMessageDialog.showDialog(context, res);
    } else {
      var res = await AuthAPI().login(widget.email, _passwordController.text);
      if (AuthManager.guestUserId != null) {
        await AuthAPI().cleanupGuestUser();
      }
      NavigationController().loading(isLoading: false);
      AuthManager().loggedIn.value = true;
      AuthManager.userModel.firstname = _firstNameController.text;
      AuthManager.userModel.lastname = _lastNameController.text;
      await AuthManager().updateUser();
      NavigationController().pushTo(context, child: DashboardPage());
    }
  }
}
