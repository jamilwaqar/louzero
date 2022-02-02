import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';
import 'package:louzero/ui/page/auth/complete.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  final int code;

  const VerifyPage({required this.email, required this.code, Key? key})
      : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _onEditing = true;

  final styleText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.dark_1,
  );
  final styleTextBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkest,
  );
  final styleTextHeading = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.darkest,
  );

  String? _code;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return AppBaseScaffold(
      logoOnly: true,
      child: AuthLayout(
        children: [
          AppCard(
            maxWidth: 512,
            px: 48,
            py: 48,
            children: [
              const Text('Verification Code', style: AppStyles.headerLarge),
              const SizedBox(
                height: 16,
              ),
              const AppTextBody('We sent a verification code to'),
              const SizedBox(height: 16),
              Text(
                widget.email,
                style: AppStyles.labelBold,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: VerificationCode(
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkest,
                  ),
                  keyboardType: TextInputType.number,
                  underlineColor: AppColors.darkest,
                  fillColor: AppColors.darkest,
                  // itemSize: 60,
                  length: 6,
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ),
              const SizedBox(height: 40),
              Buttons.submitPrimary('Continue',
                  onPressed: _completeSignup, expanded: true),
            ],
          ),
          AppTextHelpLink(
            darkMode: true,
            label: 'Haven\'t received your code yet? ',
            linkText: 'Resend Code',
            onPressed: _methodTBD,
          ),
          const SizedBox(
            height: 24,
          ),
          AppTextHelpLink(
            darkMode: true,
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

  void _completeSignup() async {
    if (_code == null || _code != widget.code.toString()) {
      var msg =
          'Sorry, the verification code you entered does not match. Please try again.';
      WarningMessageDialog.showDialog(context, msg);
      return;
    }
    Get.to(() => CompletePage(widget.email));
  }

  void _methodTBD() {}
}
