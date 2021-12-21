import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_text_help_link.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/auth/complete.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/common/app_button.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';

class AcceptInvitePage extends StatefulWidget {
  const AcceptInvitePage({Key? key}) : super(key: key);

  @override
  _AcceptInvitePageState createState() => _AcceptInvitePageState();
}

class _AcceptInvitePageState extends State<AcceptInvitePage> {
  bool _onEditing = true;
  final _emailController = TextEditingController();
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
                const SizedBox(height: 40),
                AppButton(
                  label: 'Continue',
                  onPressed: _acceptInvitation,
                ),
              ],
            ),
          ),
          AppTextHelpLink(
            label: 'Go back to ',
            linkText: 'Login',
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
    Get.to(() => CompletePage(email));
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
      print(e.toString());
    }
    NavigationController().loading(isLoading: false);
    _inviteModel = list.first;
    AuthManager.inviteModelId = _inviteModel?.objectId;
    return;
  }
}
