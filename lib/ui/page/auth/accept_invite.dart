import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/validators.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/auth_layout.dart';
import 'package:louzero/ui/page/auth/complete_signup.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';

class AcceptInvitePage extends StatefulWidget {
  const AcceptInvitePage({Key? key}) : super(key: key);
  @override
  _AcceptInvitePageState createState() => _AcceptInvitePageState();
}

class _AcceptInvitePageState extends State<AcceptInvitePage> {
  bool _onEditing = true;
  final _emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  String? _code;
  InviteModel? _inviteModel;
  bool _noInviteModel = false;

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
    return AppBaseScaffold(
      logoOnly: true,
      child: AuthLayout(
        children: [
          AppCard(
            maxWidth: 512,
            px: 48,
            py: 48,
            children: [
              Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Accept Invitation',
                      style: AppStyles.headerLarge,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Enter your email address and invitation code below.',
                      style: AppStyles.labelRegular,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AppTextField(
                      key: const ValueKey('Email Address'),
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      required: true,
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return 'Email is required';
                        }
                        if (Valid.email(val!)) {
                          return null;
                        } else {
                          return 'Enter Valid Email';
                        }
                      },
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
                    Buttons.submitPrimary(
                      'Continue',
                      expanded: true,
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          _acceptInvitation();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          AppTextHelpLink(
            darkMode: true,
            label: 'Back to',
            linkText: 'Login screen',
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  void _acceptInvitation() async {
    String email = _emailController.text;

    if (!GetUtils.isEmail(email)) {
      WarningMessageDialog.showDialog(context, "Invalid Email!");
      return;
    }

    if (_code == null) {
      WarningMessageDialog.showDialog(context, "Enter invitation code");
      return;
    }
    if (_noInviteModel) {
      WarningMessageDialog.showDialog(context, "Something wrong!");
      return;
    }
    if (_inviteModel == null) {
      await _fetchInviteModel(email);
    }

    if (isExpired(_inviteModel!.created!)) {
      WarningMessageDialog.showDialog(
          context, "Sorry, the invitation has expired");
      return;
    }
    if (_inviteModel!.inviteCode != _code) {
      var msg = 'Sorry, the code you entered does not match. Please try again.';
      WarningMessageDialog.showDialog(context, msg);
      return;
    }
    await AuthAPI(auth: Backendless.userService).logout();
    Get.to(() => CompleteSignupPage(email));
  }

  bool isExpired(DateTime createdDate) {
    var expiredDate = createdDate.add(const Duration(hours: 24));
    return DateTime.now().isAfter(expiredDate);
  }

  Future<void> _fetchInviteModel(String email) async {
    NavigationController().loading();
    var rest = await AuthAPI(auth: Backendless.userService).loginGuest();
    if (rest is String) {
      WarningMessageDialog.showDialog(context, rest);
      _noInviteModel = true;
      NavigationController().loading(isLoading: false);
      return;
    }
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$email'";
    List<InviteModel> list = [];
    try {
      var response =
          await Backendless.data.of(BLPath.invites).find(queryBuilder);
      if (response == null || response.isEmpty) {
        _noInviteModel = true;
        WarningMessageDialog.showDialog(context, "Something wrong!");
        NavigationController().loading(isLoading: false);
        return;
      }
      list =
          List<Map>.from(response).map((e) => InviteModel.fromMap(e)).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    NavigationController().loading(isLoading: false);
    _inviteModel = list.first;
    Get.find<AuthController>().inviteModelId = _inviteModel?.objectId;
    return;
  }
}
