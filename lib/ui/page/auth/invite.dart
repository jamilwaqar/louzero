import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_card_center.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/api/auth/auth.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
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
    _code = verificationCode();
    return BaseScaffold(
      child: Stack(
        children: [
          Center(
            child: AppCardCenter(
              child: Column(
                children: [
                  const AppTextHeader('Invite Customer'),
                  const SizedBox(height: 10),
                  const AppTextBody('We will sent a verification code to'),
                  AppTextBody(widget.email,
                    color: AppColors.dark_3,
                    bold: true,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        _code!.toString(),
                        style: const TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 10),
                      ),
                      const SizedBox(width: 10),
                      CupertinoButton(
                        onPressed: () {
                          setState(() {

                          });
                        },
                        padding: EdgeInsets.zero,
                        child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.medium_1,
                              shape: BoxShape.circle,
                            ),
                            child: appIcon(Icons.refresh, color: Colors.white)),
                      )
                    ],
                  ),
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
    await Future.delayed(const Duration(milliseconds: 500));
    NavigationController().loading(isLoading: false);
    var msg = res is String ? res : 'Sent an invitation with the code!';
    WarningMessageDialog.showDialog(context, msg);
    await Future.delayed(const Duration(milliseconds: 2500));
    Get.back();
  }
}
