import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/account/account_setup_complete.dart';
import 'package:louzero/ui/page/account/account_setup_customers.dart';
import 'package:louzero/ui/page/account/account_setup_job_types.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class StepItem {
  final String title;
  final String subtitle;
  final String label;
  StepItem({
    required this.title,
    required this.subtitle,
    required this.label,
  });
}

class AccountSetup extends StatefulWidget {
  const AccountSetup({Key? key}) : super(key: key);

  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final _pageController = PageController();
  int _currentStep = 0;

  List<StepItem> stepItems = [
    StepItem(
      label: 'My Company',
      title: 'To start, let\'s get some basic info.',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepItem(
      label: 'Customer Types',
      title: 'What types of customers do you have?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepItem(
      label: 'Job Types',
      title: 'What types of jobs do you do?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepItem(
      label: 'Done!',
      title: 'You’re all set, (username)!',
      subtitle: 'You can always manage these later in Settings.',
    ),
  ];

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
            child: Column(
              children: [
                AppStepProgress(
                  stepItems: stepItems,
                  selected: _currentStep,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _forms,
            ),
          )
        ],
      ),
    );
  }

  Padding _formView({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 0, right: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            child,
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                children: [
                  if (_currentStep < 3)
                    const AppDivider(
                      mb: 24,
                      color: AppColors.light_2,
                    ),
                  Row(
                    children: [
                      if (_currentStep < 3)
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
                      if (_currentStep > 0 && _currentStep < 3)
                        AppButton(
                          mb: 48,
                          label: 'Skip for Now',
                          textOnly: true,
                          ml: 16,
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
