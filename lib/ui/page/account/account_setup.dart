import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/account/account_setup_complete.dart';
import 'package:louzero/ui/page/account/account_setup_customers.dart';
import 'package:louzero/ui/page/account/account_setup_job_types.dart';
import 'package:louzero/ui/page/account/account_start.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({Key? key}) : super(key: key);

  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final _pageController = PageController();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _forms = [
      _formView(child: AccountSetupCompany()),
      _formView(child: AccountSetupCustomers()),
      _formView(child: AccountSetupJobTypes()),
      _formView(child: AccountSetupComplete()),
    ];

    return BaseScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: _pageHeading(),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: _pageController,
              //physics: const NeverScrollableScrollPhysics(),
              children: _forms,
            ),
          )
        ],
      ),
    );
  }

  Column _pageHeading() {
    return Column(
      children: [
        const AppTextHeader(
          "To start, let’s get some basic info.",
          mt: 32,
          mb: 8,
        ),
        const AppTextBody(
          'You can always make changes later in Settings',
          mb: 32,
          bold: true,
        ),
        AppStepProgress(
          steps: const ['My Company', 'Customer Types', 'Job Types', 'Done!'],
          selected: _currentStep,
        ),
      ],
    );
  }

  Padding _formView({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 40, right: 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            child,
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                children: [
                  const AppDivider(
                    mb: 24,
                    color: AppColors.light_2,
                  ),
                  Row(
                    children: [
                      AppButton(
                        mb: 48,
                        label: 'Save & Continue',
                        onPressed: () {
                          setState(() {
                            _currentStep++;
                          });
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
