import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/auth/complete.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/common/app_button.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class AcceptInvitePage extends StatefulWidget {
  const AcceptInvitePage({Key? key}) : super(key: key);

  @override
  _AcceptInvitePageState createState() => _AcceptInvitePageState();
}

class _AcceptInvitePageState extends State<AcceptInvitePage> {
  bool _onEditing = true;
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppCardCenter(
            child: Column(
              children: [
                const AppTextHeader(
                  'Accept Invitation',
                ),
                const AppTextBody(
                  'Enter your email address and invitation code below.',
                  mb: 40,
                ),
                AppInputText(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                ),
                VerificationCode(
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkest,
                  ),
                  keyboardType: TextInputType.number,
                  underlineColor: AppColors.darkest,
                  fillColor: AppColors.darkest,
                  length: 6,
                  onCompleted: (String value) {
                    setState(() {
                      // _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 40),
                AppButton(
                  label: 'Continue',
                  onPressed: _completeSignup,
                ),
              ],
            ),
          ),
          AppTextHelpLink(
            label: 'Go back to ',
            linkText: 'Login',
            onPressed: _goback,
          ),
        ],
      ),
    );
  }

  void _goback() async {
    NavigationController().pop(context);
  }

  void _completeSignup() {
    NavigationController().pushTo(context, child: const CompletePage());
  }
}
