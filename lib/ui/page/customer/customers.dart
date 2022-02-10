import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/ui/page/demo/demo.dart';
import 'customer.dart';

class CustomerListPage extends GetWidget<CustomerController> {
  const CustomerListPage({Key? key}) : super(key: key);

  final int mockId = 8520;
  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _body(),
      ),
      subheader: 'Customers',
      footerEnd: [
        AppBarButtonAdd(
          label: 'New Customer',
          onPressed: () {
            Get.to(() => const AddCustomerPage());
          },
        )
      ],
    );
  }

  Widget _body() {
    return GetBuilder<CustomerController>(
        builder: (_) => ListView.builder(
            padding: const EdgeInsets.only(top: 32),
            shrinkWrap: true,
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              CustomerModel model = controller.customers[index];
              return AppCard(
                mb: 8,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.customerModel = model;
                      Get.to(() => const CustomerProfilePage());
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
                                model.companyName,
                                color: AppColors.darkest,
                                bold: true,
                              ),
                              AppTextBody(
                                model.serviceAddress.fullAddress,
                              )
                            ],
                          ),
                          AppTextBody(
                            model.type,
                          ),
                          AppPopMenu(
                            button: const [
                              Icon(Icons.control_point_rounded,
                                  size: 40, color: AppColors.orange),
                            ],
                              items:List.generate(CustomerPopMenu.values.length, (index) {
                                final menu = CustomerPopMenu.values[index];
                                return PopMenuItem(
                                  label: menu.label,
                                  icon: menu.icon,
                                  onTap: menu.onTap(model),
                                );
                              }),
                          ),
                        ]),
                  )
                ],
              );
            }));

  }
}

enum CustomerPopMenu {
  edit, delete, invite
}

extension CustomerPopMenuEx on CustomerPopMenu {
  String get label {
    switch(this) {
      case CustomerPopMenu.edit:
        return 'Edit';
      case CustomerPopMenu.delete:
        return 'Delete';
      case CustomerPopMenu.invite:
        return 'Invite';
    }
  }

  IconData get icon {
    switch(this) {
      case CustomerPopMenu.edit:
        return Icons.edit;
      case CustomerPopMenu.delete:
        return Icons.delete;
      case CustomerPopMenu.invite:
        return Icons.mail_outline_rounded;
    }
  }

  VoidCallback onTap(CustomerModel model) {
    const popMenuHideDuration = Duration(milliseconds: 100);
    switch(this) {
      case CustomerPopMenu.edit:
        return () {
          Future.delayed(popMenuHideDuration)
              .then((value) => Get.to(
                  () => AddCustomerPage(model: model)));
        };
      case CustomerPopMenu.delete:
        return () async {
          await Future.delayed(popMenuHideDuration);
            NavigationController().loading();
            await Get.find<CustomerController>().deleteCustomer(
                model.objectId!,
                Backendless.data.of(BLPath.customer));
            NavigationController()
                .loading(isLoading: false);
        };
      case CustomerPopMenu.invite:
        return () {
          Future.delayed(popMenuHideDuration)
              .then((value) => Get.to(
                  () => Demo()));
        };
    }
  }
}