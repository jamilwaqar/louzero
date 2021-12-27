import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/customer_info.dart';

class CustomerProfilePage extends GetWidget<CustomerController> {
  const CustomerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: controller.customerModel.value!.customerContacts.first.fullName,
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
              CustomerInfo(controller.customerModel.value!),
              const SizedBox(height: 24),
              _category()
            ],
          );
        });
  }

  Widget _category() {
    List<Widget> itemList = List.generate(CustomerCategory.values.length,
        (index) => _categoryItem(CustomerCategory.values[index])).toList();
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      children: itemList,
      childAspectRatio: 2.4 / 1,
    );
  }

  Widget _categoryItem(CustomerCategory category) {
    int count = 0;
    switch (category) {
      case CustomerCategory.jobs:
        break;
      case CustomerCategory.siteProfiles:
        count = controller.customerModel.value!.siteProfiles.length;
        break;
      case CustomerCategory.contacts:
        break;
      case CustomerCategory.pictures:
        break;
      case CustomerCategory.notes:
        break;
      case CustomerCategory.subAccounts:
        break;
    }
    return InkWell(
      onTap: () {
        switch (category) {
          case CustomerCategory.jobs:
            break;
          case CustomerCategory.siteProfiles:
            count = controller.customerModel.value!.siteProfiles.length;
            Get.to(() => CustomerSiteProfilePage(
                controller.customerModel.value!.siteProfiles,
                customerId: controller.customerModel.value!.objectId));
            break;
          case CustomerCategory.contacts:
            break;
          case CustomerCategory.pictures:
            break;
          case CustomerCategory.notes:
            break;
          case CustomerCategory.subAccounts:
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.light_1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(category.title,
                              style: TextStyles.titleL
                                  .copyWith(color: AppColors.dark_3))),
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.light_2,
                        ),
                        child: Text('$count',
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.dark_3,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category.description,
                    style: TextStyles.bodyM.copyWith(color: AppColors.dark_3),
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
