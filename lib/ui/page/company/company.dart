import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';
import 'package:louzero/ui/widget/customer_info.dart';

class CompanyPage extends GetWidget<CompanyController> {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: controller.companyModel.value!.name,
    );
  }

  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _info(),
            ],
          );
        });
  }

  Widget _info() {
    CompanyModel model = controller.companyModel.value!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(model.name,
                                  style: TextStyles.headLineS
                                      .copyWith(color: AppColors.dark_2)),
                              const SizedBox(width: 8),
                              TopLeftButton(
                                  onPressed: () {}, iconData: Icons.edit),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                flex:4,
                                child: Text(model.address!.fullAddress,
                                    style: TextStyles.bodyL, overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(width: 50),
                              appIcon(Icons.attach_money),
                              const SizedBox(width: 3),
                              Text('Acct. Balance:',
                                  style: TextStyles.bodyL
                                      .copyWith(color: AppColors.dark_2)),
                              Text("\$0.00:",
                                  style: TextStyles.bodyL
                                      .copyWith(color: AppColors.darkest)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CupertinoButton(
                  onPressed: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.light_4.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30)),
                    child: SvgPicture.asset(
                        "${Constant.imgPrefixPath}/icon-collapse.svg"),
                  ))
            ],
          ),
          SizedBox(
            height: 472,
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 246,
                      height: 472,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8))),
                    ),
                    Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            // Get.to(()=> CustomerLocationPage(customerModel));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            child: Image.asset(
                                "assets/icons/icon-full-screen.png"),
                          ),
                        )),
                  ],
                ),
                const SizedBox(width: 21),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(
                          thickness: 2, color: AppColors.light_1, height: 0),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 103,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: AppColors.light_1),
                          child: Text('RESIDENTIAL',
                              style: TextStyles.bodyL.copyWith(fontSize: 12)),
                        ),
                      ),
                      Row(
                        children: [
                          appIcon(Icons.person, color: AppColors.dark_1),
                          const SizedBox(width: 8),
                          const Text('Primary Contact',
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
                            Text(model.name,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
                            Text(model.email,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
                            Text(model.phone,
                                style: TextStyles.bodyL
                                    .copyWith(color: AppColors.dark_3)),
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
                            // if (fromJob)
                            //   Column(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       const SizedBox(height: 16),
                            //       const Divider(
                            //           thickness: 2, color: AppColors.light_1, height: 0),
                            //       const SizedBox(height: 16,),
                            //       Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           _bottomButton("Site Profile", Icons.home_work, () {}),
                            //           const SizedBox(width: 8,),
                            //           _bottomButton("Notes", Icons.note_sharp, () {}),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
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
    );
  }
}
