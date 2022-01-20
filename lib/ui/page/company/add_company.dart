import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';

class AddCompanyPage extends GetWidget<CompanyController> {
  const AddCompanyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: Column(
        children: [
          const SizedBox(height: 32),
          AccountSetupCompany(
            companyModel: controller.company,
          ),
        ],
      ),
      subheader:
          controller.company.name.isEmpty ? "Add New Company" : "Edit Company",
    );
  }
}
