import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/page/company/company.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';

class MyAccountPage extends GetWidget<CompanyController> {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBaseScaffold(
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 32),
        itemBuilder:(_, __) =>  _body(),
      ),
      subheader: 'My Account',
    );
  }

  Widget _body() {
    return Column(
      children: [
        _accountInfo(),
        const SizedBox(height: 24),
        GetBuilder<CompanyController>(builder:(_)=> ListView.builder(
            padding: const EdgeInsets.only(top: 32),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
            })),
      ],
    );
  }

  Widget _accountInfo() {
    return AppCard(
      radius: 16,
      pl: 0,
      pt: 0,
      pb: 0,
      pr: 0,
      children:[
        SizedBox(
          height: 432,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    height: 75,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            appIcon(Icons.attach_money),
                            Text('My Account',
                                style: TextStyles.headLineS
                                    .copyWith(color: AppColors.dark_2)),
                            const SizedBox(width: 8),
                            TopLeftButton(
                                onPressed: () {
                                  // // Get.find<CustomerController>().customerModel = customerModel;
                                  // Get.to(() => AddCustomerPage(model: customerModel,));
                                }, iconData: Icons.edit),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 246,
                      padding: const EdgeInsets.symmetric(vertical: 31),
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                          color: AppColors.light_1,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8))),
                      child: _profile(),
                    ),
                    const SizedBox(width: 21),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                              thickness: 2, color: AppColors.light_1, height: 0),
                          Row(
                            children: [
                              appIcon(Icons.person, color: AppColors.dark_1),
                              const SizedBox(width: 8),
                              const Text('Name',
                                  style: TextStyles.labelL),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Text(customerModel.customerContacts[0].fullName,
                                //     style: TextStyles.bodyL
                                //         .copyWith(color: AppColors.dark_3)),
                                // Text(customerModel.customerContacts[0].email,
                                //     style: TextStyles.bodyL
                                //         .copyWith(color: AppColors.dark_3)),
                                // Text(customerModel.customerContacts[0].phone,
                                //     style: TextStyles.bodyL
                                //         .copyWith(color: AppColors.dark_3)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              appIcon(Icons.location_pin, color: AppColors.dark_1),
                              const SizedBox(width: 8),
                              const Text('Billing Address',
                                  style: TextStyles.labelL),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 32.0),
                                  child: Text('Same as Service Address',
                                      style: TextStyles.bodyL
                                          .copyWith(color: AppColors.dark_3)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              )
            ],
          ),
        )
      ] ,
    );
  }

  Widget _profile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAvatar(url: AuthManager.userModel!.avatar, text: AuthManager.userModel!.initials, size: 96, backgroundColor: AppColors.medium_2),
        const SizedBox(height: 8),
        Text(AuthManager.userModel!.fullName, style: AppStyles.header_default),
        const SizedBox(height: 8),

      ],
    );
  }
}
