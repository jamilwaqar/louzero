import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/page/company/company.dart';

class CompanyListPage extends GetWidget<CompanyController> {
  const CompanyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBaseScaffold(
      child: Column(children: [
        Expanded(child: _body()),
      ]),
      subheader: 'My Account',
      footerEnd: [
        AppBarButtonAdd(
          label: 'New Company',
          onPressed: () {
            controller.company = CompanyModel();
            Get.to(()=> const AddCompanyPage());
          },
        )
      ],
    );
  }

  Widget _body() {
    return GetBuilder<CompanyController>(builder:(_)=> ListView.builder(
        padding: const EdgeInsets.only(top: 32),
        shrinkWrap: true,
        itemCount: controller.companies.length,
        itemBuilder: (context, index) {
          CompanyModel model = controller.companies[index];
          return AppCard(
            mb: 8,
            children: [
              GestureDetector(
                onTap: () {
                  controller.company = model;
                  Get.to(() => CompanyPage(),
                      arguments: model);
                },
                child: AppRowFlex(
                    flex: const [1, 5, 2, 0],
                    align: CrossAxisAlignment.center,
                    mb: 0,
                    children: [
                      AppAvatar(url: model.avatar, size: 60, placeHolder: AppPlaceHolder.company,),
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
                        Get.find<BaseController>().activeCompany!.objectId ==
                            model.objectId
                            ? 'Active'
                            : '',
                        color: AppColors.accent_1,
                      ),
                      PopupMenuButton(
                          offset: const Offset(0, 40),
                          onSelected: (value) async {
                            if (value == 0) {
                              await Get.find<CompanyController>().createOrEditCompany(model,
                                  addressModel: model.address!,
                                  isEdit: true,
                                  isActiveCompany: true);
                            } else if (value == 1) {
                              controller.company = model;
                              Get.to(()=> const AddCompanyPage());
                            } else if (value == 2)  {
                              controller.deleteCompany(model.objectId!);
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
                                      Icons.check,
                                      color: AppColors.icon,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Active",
                                        style: TextStyle(
                                          color: AppColors.icon,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: SizedBox(
                                width: 100,
                                height: 60,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: AppColors.icon,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Edit",
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
                            PopupMenuItem(
                              child: SizedBox(
                                width: 100,
                                height: 60,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: AppColors.icon,
                                    ),
                                    SizedBox(width: 10),
                                    Text("Delete",
                                        style: TextStyle(
                                          color: AppColors.icon,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              value: 2,
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
