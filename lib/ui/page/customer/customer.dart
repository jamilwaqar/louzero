import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';

class CustomerProfilePage extends GetWidget<CustomerController> {
  const CustomerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: controller.customerModel!.customerContacts.first.fullName,
    );
  }

  String _customerFullName() {
    var customer = controller.customerModel!.customerContacts[0];
    return "${customer.firstName} ${customer.lastName}";
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContactCard(
            title: _customerFullName() + "(dev in progress)",
            contact: controller.customerModel!.customerContacts[0],
            address: controller.customerModel!.serviceAddress,
            trailing: const TextKeyVal('Account Balance', '\$0.00'),
            onClickIcon: () {
              Get.to(() => AddCustomerPage(
                    model: controller.customerModel,
                  ));
            },
          ),
          _category()
        ],
      ),
    );
  }

  Widget _category() {
    List<Widget> itemList = List.generate(CustomerCategory.values.length,
        (index) => _categoryItem(CustomerCategory.values[index])).toList();
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      shrinkWrap: true,
      children: itemList,
      childAspectRatio: 16 / 9,
    );
  }

  Widget _categoryItem(CustomerCategory category) {
    return GestureDetector(
      onTap: () {
        if (category == CustomerCategory.siteProfiles) {
          Get.to(() => CustomerSiteProfilePage(
              controller.customerModel!.siteProfiles,
              customerId: controller.customerModel!.objectId));
        }
      },
      child: AppCard(
        mx: 0,
        my: 0,
        py: 16,
        children: [
          RowSplit(
            align: 'center',
            left: Text(category.title, style: AppStyles.headerDialog),
            right: const Text('0'),
          ),
          const AppDivider(mt: 8),
          Text(
            category.description,
            style: AppStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
