import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_image.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/bindings/company_binding.dart';
import 'package:louzero/controller/get/bindings/customer_binding.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/ui/page/account/account.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import '../app_base_scaffold.dart';

enum SettingType {
  account,
  company,
  users,
  checklist,
  customerType,
  jobType,
  taxRate,
  siteProfileTemplate
}

extension SettingEx on SettingType {
  String get title {
    switch (this) {
      case SettingType.account:
        return 'My Account';
      case SettingType.company:
        return 'My Company';
      case SettingType.users:
        return 'Manage Users';
      case SettingType.checklist:
        return 'Checklists';
      case SettingType.customerType:
        return 'Customer Types';
      case SettingType.jobType:
        return 'Job Types';
      case SettingType.taxRate:
        return 'Tax Rates';
      case SettingType.siteProfileTemplate:
        return 'Site Profile Templates';
    }
  }

  String get description {
    switch (this) {
      case SettingType.account:
        return 'Manage my account details and easily make updates to my information.';
      case SettingType.company:
        return 'View, edit, and manage my company details and information.';
      case SettingType.users:
        return 'Add and manage users within my company.';
      case SettingType.checklist:
        return 'Provide a quick way to select services performed while on the job.';
      case SettingType.customerType:
        return 'Organize customers into various types and edit, remove, and reorder.';
      case SettingType.jobType:
        return 'Set up common Job Type “templates” with default info to save time later.';
      case SettingType.taxRate:
        return 'Define tax rates and supports what tax rates will look like if none defined.';
      case SettingType.siteProfileTemplate:
        return 'Name a site profile so it can be easily applied to customers and jobs';
    }
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final BaseController _baseController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: "Settings",
    );
  }

  Widget _body() {
    List<Widget> itemList = List.generate(SettingType.values.length,
            (index) => _categoryItem(SettingType.values[index])).toList();
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      children: itemList,
      childAspectRatio: 2.4 / 1,
    );
  }

  Widget _categoryItem(SettingType category) {
    return InkWell(
      onTap: () {
        switch (category) {
          case SettingType.account:
            Get.to(() => MyAccountPage(AuthManager.userModel!),
                binding: CompanyBinding());
            break;
          case SettingType.company:
            // TODO: Handle this case.
            break;
          case SettingType.users:
            // TODO: Handle this case.
            break;
          case SettingType.checklist:
            // TODO: Handle this case.
            break;
          case SettingType.customerType:
            // TODO: Handle this case.
            break;
          case SettingType.jobType:
            // TODO: Handle this case.
            break;
          case SettingType.taxRate:
            // TODO: Handle this case.
            break;
          case SettingType.siteProfileTemplate:
            Get.to(()=> CustomerSiteProfilePage(
                _baseController.siteProfileTemplates,
                isTemplate: true), binding: CustomerBinding());
            break;
        }
      },
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: AppImage('icon-setting-placeholder', width: 80, height: 80),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(category.title,
                      style: TextStyles.titleL
                          .copyWith(color: AppColors.dark_3)),
                  const SizedBox(height: 8),
                  Text(
                    category.description,
                    style: TextStyles.bodyM.copyWith(color: AppColors.dark_1),
                    maxLines: 2,
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
