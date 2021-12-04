import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_inline_form.dart';
import 'package:louzero/common/app_list_draggable.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/account/account_setup_complete.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'models/company_model.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({Key? key}) : super(key: key);

  @override
  _AccountSetupState createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
  final _pageController = PageController();

  var _step = 0;

  CompanyModel _companyModel = CompanyModel();

  final customerTypes = ["Residential", "Commerical"];

  final customerTypeController = TextEditingController();

  final jobTypes = ["Installation", "Consulting", "Estimate"];

  final jobTypeController = TextEditingController();

  List<StepProgressItem> stepItems = [
    StepProgressItem(
      label: 'My Company',
      title: 'To start, let\'s get some basic info.',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Customer Types',
      title: 'What types of customers do you have?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Job Types',
      title: 'What types of jobs do you do?',
      subtitle: 'You can always make changes later in Settings.',
    ),
    StepProgressItem(
      label: 'Done!',
      title: 'You’re all set, (username)!',
      subtitle: 'You can always manage these later in Settings.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                AppStepProgress(
                  stepItems: stepItems,
                  selected: _step,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: PageView(
              controller: _pageController,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                _formView(
                    child: AccountSetupCompany(
                  data: _companyModel,
                  onChange: (data) => _updateCompany(data),
                )),
                _formView(child: _customersCard()),
                _formView(child: _jobsCard()),
                _formView(child: AccountSetupComplete()),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _updateCompany(CompanyModel data) {
    setState(() {
      _step++;
      _companyModel = data;
    });
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    inspect(data);
  }

  _addCustomer() {
    if (customerTypes.contains(customerTypeController.value.text)) {
      return;
    } else {
      setState(() {
        customerTypes.add(customerTypeController.value.text);
      });
    }
  }

  _addJobType() {
    if (jobTypes.contains(jobTypeController.value.text)) {
      return;
    } else {
      setState(() {
        jobTypes.add(jobTypeController.value.text);
      });
    }
  }

  Widget _formView({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 0, right: 0),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }

  Widget _customersCard() => AppCard(
        children: [
          const AppTextHeader(
            "Customer Types",
            alignLeft: true,
            icon: Icons.people,
            size: 24,
          ),
          const AppTextBody(
              'Customer Types allow for categorization of customers. Common options are residential and commercial. This categorization will be helpful in reporting on performance.'),
          AppListDraggable(
            items: customerTypes,
          ),
          const Divider(
            color: AppColors.light_3,
          ),
          AppInputInlineForm(
            mt: 14,
            controller: customerTypeController,
            label: 'Add new Customer Type',
            btnLabel: 'ADD',
            onPressed: _addCustomer,
          ),
        ],
      );

  Widget _jobsCard() => AppCard(
        children: [
          const AppTextHeader(
            "Job Types",
            alignLeft: true,
            icon: MdiIcons.briefcase,
            size: 24,
          ),
          const AppTextBody(
              'Save time by profiling your common job types. Think about repairs, sales and recurring services. Later, you can build out full templates for each job type in Settings.'),
          AppListDraggable(
            items: jobTypes,
          ),
          const Divider(
            color: AppColors.light_3,
          ),
          AppInputInlineForm(
            mt: 14,
            controller: jobTypeController,
            label: 'Add new Customer Type',
            btnLabel: 'ADD',
            onPressed: _addJobType,
          ),
        ],
      );
}
