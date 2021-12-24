import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_inline_form.dart';
import 'package:louzero/common/app_list_draggable.dart';
import 'package:louzero/common/app_list_tile.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_divider.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
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

  var customerTypes = ["Residential", "Commercial"];

  final customerTypeController = TextEditingController();

  var jobTypes = ["Installation", "Consulting", "Estimate"];

  final jobTypeController = TextEditingController();

  @override
  void initState() {
    if (AuthManager.userModel!.customerTypes.isNotEmpty) {
      customerTypes = AuthManager.userModel!.customerTypes;
    }

    if (AuthManager.userModel!.jobTypes.isNotEmpty) {
      jobTypes = AuthManager.userModel!.jobTypes;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: Column(
        children: [
          Expanded(
              flex: 0,
              child: AppStepProgress(
                stepItems: AccountSetupModel.stepItems,
                selected: _step,
              )),
          const SizedBox(height: 32),
          Expanded(
            child: PageView(
              controller: _pageController,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                _scrollView(
                  AccountSetupCompany(
                    onChange: _saveFormInput,
                  ),
                ),
                _scrollView(customerCard()),
                _scrollView(jobsCard()),
                _scrollView(completeCard())
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveFormInput() {
    _nextStep();
  }

  void _nextStep() {
    setState(() {
      _step++;
    });
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
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

  _goToDashboard(context) {
    NavigationController().pop(context);
    NavigationController().pushTo(context, child: DashboardPage());
  }

  Widget _scrollView(Widget child) {
    return SingleChildScrollView(child: child);
  }

  Widget customerCard() => Column(
        children: [
          AppCard(
            children: [
              const AppTextHeader(
                "Customer Types",
                alignLeft: true,
                icon: Icons.people,
                size: 24,
              ),
              const AppTextBody(AccountSetupModel.setupCompanyText),
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
          ),
          Row(
            children: [
              AppButton(
                  margin: const EdgeInsets.only(left: 24, bottom: 64),
                  label: 'Save & Continue',
                  onPressed: () async {
                    AuthManager.userModel!.customerTypes = customerTypes;
                    NavigationController().loading();
                    await AuthManager().updateUser();
                    NavigationController().loading(isLoading: false);
                    _saveFormInput();
                  }),
            ],
          ),
        ],
      );

  Widget jobsCard() => Column(
        children: [
          AppCard(
            children: [
              const AppTextHeader(
                "Job Types",
                alignLeft: true,
                icon: MdiIcons.briefcase,
                size: 24,
              ),
              const AppTextBody(AccountSetupModel.setupJobsText),
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
          ),
          Row(
            children: [
              AppButton(
                  margin: const EdgeInsets.only(left: 24, bottom: 64),
                  label: 'Save & Continue',
                  onPressed: () async {
                    AuthManager.userModel!.jobTypes = jobTypes;
                    NavigationController().loading();
                    await AuthManager().updateUser();
                    NavigationController().loading(isLoading: false);
                    _saveFormInput();
                  }),
            ],
          ),
        ],
      );

  Widget completeCard() => Column(
        children: [
          AppCard(
            children: [
              const AppTextHeader(
                "Welcome to LOuZero",
                size: 24,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 52, right: 52, bottom: 32),
                child: AppTextBody(
                  AccountSetupModel.setupCompleteText,
                  center: true,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: AccountSetupModel.nextStepItems
                      .asMap()
                      .entries
                      .map((entry) {
                    int idx = entry.key;
                    ListItem item = entry.value;
                    var isOdd = idx % 2 == 0 ? false : true;
                    return AppListTile(
                      title: item.title ?? '',
                      subtitle: item.subtitle ?? '',
                      colorBg:
                          isOdd ? Colors.grey.shade50 : Colors.grey.shade200,
                      onTap: () {
                        _goToDashboard(context);
                      },
                    );
                  }).toList(),
                ),
              ),
              const AppTextDivider(
                ml: 150,
                mr: 150,
              ),
              AppButton(
                label: 'Go to Your Dashboard',
                color: AppColors.dark_2,
                fontSize: 13,
                onPressed: () {
                  _goToDashboard(context);
                },
              )
            ],
          ),
        ],
      );
}
