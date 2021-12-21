import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/bindings/company_binding.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/account/account_setup_company.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/company.dart';

class CompanyListPage extends StatelessWidget {

  CompanyListPage({Key? key}) : super(key: key);

  final int mockId = 8520;
  final BaseController _baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: Column(children: [
        Expanded(child: _body()),
      ]),
      subheader: 'Companies',
      footerEnd: [
        AppBarButtonAdd(
          label: 'New Company',
          onPressed: () {
            // NavigationController()
            //     .pushTo(context, child: const AddCustomerPage());
          },
        )
      ],
    );
  }

  Widget _body() {
    return Obx(() => ListView.builder(
        padding: const EdgeInsets.only(top: 32),
        shrinkWrap: true,
        itemCount: _baseController.companies.value.length,
        itemBuilder: (context, index) {
          CompanyModel model = _baseController.companies.value[index];
          return AppCard(
            mb: 8,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const CompanyPage(),
                      arguments: model, binding: CompanyBinding());
                },
                child: AppRowFlex(
                    flex: const [1, 5, 2, 0],
                    align: CrossAxisAlignment.center,
                    mb: 0,
                    children: [
                      AppTextBody('#$mockId'),
                      Column(
                        children: [
                          AppTextBody(
                            model.name,
                            color: AppColors.darkest,
                            bold: true,
                          ),
                          AppTextBody(
                            model.address!.fullAddress,
                          )
                        ],
                      ),
                      AppTextBody(
                        model.name,
                      ),
                      PopupMenuButton(
                          offset: const Offset(0, 40),
                          onSelected: (value) {
                            if (value == 1) {
                              // Get.to(() => InviteCustomerPage(
                              //     email: model.customerContacts.first.email));
                            }
                          },
                          elevation: 2,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.medium_2, width: 0)),
                          child: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: SizedBox(
                                    width: 100,
                                    height: 60,
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.supervised_user_circle,
                                          color: AppColors.icon,
                                        ),
                                        SizedBox(width: 10),
                                        Text("Invite",
                                            style: TextStyle(
                                              color: AppColors.icon,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                  value: 1,
                                ),
                              ]),
                      // Icon(Icons.more_vert)
                    ]),
              )
            ],
          );
        }));
  }
}
