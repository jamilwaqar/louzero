import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/account/account_setup_complete.dart';
import 'package:louzero/ui/page/account/account_setup_customers.dart';
import 'package:louzero/ui/page/account/account_setup_job_types.dart';
import 'package:louzero/ui/page/account/account_start.dart';
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

  final List<StepItem> stepItems = [
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
      label: 'Job Types',
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
      _formView(child: SampleForm()),
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

class SampleForm extends StatelessWidget {
  const SampleForm({Key? key}) : super(key: key);

  Widget getFormFeild(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Complex form layout example:

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          mb: 24,
          children: [
            const AppTextHeader(
              'Location',
              icon: Icons.location_on_sharp,
              alignLeft: true,
              size: 28,
              mb: 24,
            ),
            AppRowFlex(
              flex: const [2, 1],
              children: [
                getFormFeild('Street Address'),
                getFormFeild('Suite'),
              ],
            ),
            AppRowFlex(
              flex: const [3, 2, 1],
              children: [
                getFormFeild('City'),
                getFormFeild('State'),
                getFormFeild('Zip'),
              ],
            ),
            AppRowFlex(
              flex: const [1, 1],
              children: [
                getFormFeild('Email'),
                getFormFeild('Phone'),
              ],
            ),
            AppRowFlex(
              mb: 0,
              mt: 8,
              flex: [3, 2, 1],
              children: [
                Container(),
                const AppButton(
                  label: 'Update Location',
                  wide: true,
                ),
                const AppButton(
                  label: 'cancel',
                  primary: false,
                  wide: true,
                ),
              ],
            ),
          ],
        ),
        AppCard(
          mt: 24,
          children: [
            const AppTextHeader(
              'Character',
              icon: Icons.emoji_emotions_outlined,
              alignLeft: true,
              size: 28,
              mb: 24,
            ),
            AppRowFlex(
              flex: const [1, 1, 1],
              children: [
                Container(
                  height: 60,
                  color: Colors.grey.shade100,
                ),
                getFormFeild('Super Power'),
                getFormFeild('Battle Cry'),
              ],
            ),
            AppRowFlex(
              children: [
                getFormFeild('Nickname'),
                getFormFeild('Title'),
                Container(
                  height: 60,
                  color: Colors.grey.shade100,
                ),
              ],
            ),
            AppRowFlex(
              flex: const [4, 1],
              children: [
                getFormFeild('Short Description Here...'),
              ],
            ),
            AppRowFlex(
              mb: 0,
              mt: 8,
              flex: [4, 2, 2],
              children: [
                Container(),
                AppButton(
                    label: 'Level Up!',
                    wide: true,
                    color: Colors.blueGrey.shade800),
                AppButton(
                  label: 'cancel',
                  primary: false,
                  wide: true,
                  color: Colors.red.shade200,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
