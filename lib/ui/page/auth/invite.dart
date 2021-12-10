import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/ui/widget/dialolg/warning_dialog.dart';

class InviteCustomerPage extends StatefulWidget {
  final String email;

  const InviteCustomerPage({required this.email, Key? key})
      : super(key: key);

  @override
  _InviteCustomerPageState createState() => _InviteCustomerPageState();
}

class _InviteCustomerPageState extends State<InviteCustomerPage> {

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

  int? _code;

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
    _code = Random().nextInt(999999);
    return BaseScaffold(
      child: Stack(
        children: [
          Center(
            child: AppCardCenter(
              child: Column(
                children: [
                  const AppTextHeader('Invite Customer'),
                  // const AppTextBody('We sent a verification code to'),
                  AppTextBody(widget.email,
                    color: AppColors.dark_3,
                    bold: true,
                  ),
                  // const AppTextBody('Enter that code to continue',
                  //     mt: 24, mb: 16),
                  AppTextHeader(_code!.toString()),
                  const SizedBox(height: 40),
                  AppButton(
                    label: 'Invite',
                    onPressed: _inviteCustomer,

                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
              left: 30,
              child: _leading)
        ],
      ),
    );
  }

  Widget get _leading {
    return CupertinoButton(
      onPressed: ()=> Get.back(),
      child: const Icon(Icons.arrow_back, color: AppColors.icon, size: 30),
    );
  }

  void _inviteCustomer() async {
    NavigationController().loading();
    var res = await AuthAPI().sendInvitationCode(widget.email, _code!);
    await Future.delayed(const Duration(seconds: 1));
    var msg = res is String ? res : 'Sent an invitation with the code!';
    WarningMessageDialog.showDialog(context, msg);
    NavigationController().loading(isLoading: false);
    Get.back();
  }
}
