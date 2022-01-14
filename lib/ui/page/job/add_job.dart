import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'views/widget/contact_card.dart';

enum SelectCustomerType { none, search, select }

class AddJobPage extends GetWidget<JobController> {
  final JobModel? jobModel;
  AddJobPage({this.jobModel, Key? key}) : super(key: key);


  final _baseController = Get.find<BaseController>();
  final TextEditingController _customerNameController = TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController(text: jobModel?.description);
  late final List<String> _jobTypes = AuthManager.userModel!.jobTypes;
  late final List<String> _customerList = _baseController.customers.map((e) => e.objectId!).toList();
  final _status = JobStatus.estimate.obs;
  late final _jobType = Rx<String?>(jobModel?.jobType);
  late final _customerId = Rx<String?>(jobModel?.customerId);
  final _selectCustomerType = SelectCustomerType.none.obs;

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'Add New Job',
      child: _body(),
    );
  }

  Widget _body() {
    List<Widget> list = [
      const SizedBox(
        height: 32,
      ),
      _addCustomer(),
      const SizedBox(height: 24),
      _jobDetailsWidget(),
      const SizedBox(height: 32),
      const Divider(),
      const SizedBox(height: 24),
      _saveOrCancel(),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        // padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),
        children: list,
      ),
    );
  }

  Widget _addCustomer() {
    return Obx(() {
      if (_customerId.value != null) {
        CustomerModel model = _baseController.customers
            .firstWhere((e) => e.objectId == _customerId.value);

        return ContactCard(
          title: model.customerContacts[0].fullName,
          contact: model.customerContacts[0],
          address: model.billingAddress,
          trailing: const TextKeyVal('Account Balance', '\$0.00'),
          onClickIcon: () {
            Get.to(() => AddCustomerPage(
                  model: model,
                ));
          },
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _itemTitle("Customer", Icons.person),
            const SizedBox(height: 32),
            const Text(
              "Select Customer",
              style: TextStyle(
                color: AppColors.dark_1,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(child: _chooseCustomer()),
                const SizedBox(width: 32),
                Flexible(
                  child: AppAddButton(
                    "Add New Customer",
                    onPressed: () => Get.to(() => const AddCustomerPage()),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } );
  }

  Widget _chooseCustomer() {
    return Obx(() => Container(
        height: 48,
        alignment: Alignment.center,
        padding: _selectCustomerType.value == SelectCustomerType.none
            ? const EdgeInsets.symmetric(horizontal: 16)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.light_3,
              width: 1,
            )),
        child: _selectCustomerType.value == SelectCustomerType.none
            ? Row(
                children: [
                  const Expanded(child: SizedBox()),
                  InkWell(
                      onTap: () =>
                          _selectCustomerType.value = SelectCustomerType.search,
                      child: appIcon(Icons.search)),
                  const SizedBox(width: 8),
                  InkWell(
                      onTap: () =>
                          _selectCustomerType.value = SelectCustomerType.select,
                      child: appIcon(Icons.arrow_drop_down)),
                ],
              )
            : _selectCustomerType.value == SelectCustomerType.search
                ? Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextFormField(
                      autofocus: true,
                      controller: _customerNameController,
                      keyboardAppearance: Brightness.light,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: () => _selectCustomerType.value =
                                SelectCustomerType.none,
                            child: appIcon(Icons.close),
                          )),
                      onChanged: (val) {},
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.dark_3,
                      ),
                    ),
                  )
                : _customerDropdown()));
  }

  Widget _jobDetailsWidget() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.light_2, width: 1),
            color: AppColors.lightest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/icons/icon-bag.png",
                      width: 24, height: 24),
                  const SizedBox(width: 8),
                  const Text("Job Details", style: TextStyles.titleM),
                ],
              ),
              // _itemTitle("Job Details", Icons.shopping_bag),
              const SizedBox(height: 32),
              Row(
                children: [
                  Flexible(
                      child: AppDropDown(
                    label: "Job Type*",
                    itemList: _jobTypes,
                    initValue: _jobType.value,
                    onChanged: (value) {
                      _jobType.value = value;
                    },
                  )),
                  const SizedBox(width: 32),
                  const Flexible(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 24),
              const Text("Job Status", style: TextStyles.bodyL),
              const SizedBox(height: 10),
              _jobStatusItem(JobStatus.estimate),
              const SizedBox(height: 8),
              _jobStatusItem(JobStatus.booked),
              const SizedBox(height: 24),
              _jobDescription(),
            ],
          ),
        ));
  }

  Widget _customerDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InputDecorator(
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.dark_3,
          ),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
          // hintText: hint,
        ),
        isEmpty: _customerId.value == null,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _customerId.value,
            isDense: true,
            onChanged: (val) => _customerId.value = val,
            items: _customerList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(_baseController.customerModelById(value)!.customerContacts[0].fullName),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _jobStatusItem(JobStatus status) {
    return Obx(() => Container(
          height: 35,
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
            onPressed: () => _status.value = status,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                appIcon(_status.value == status
                    ? Icons.radio_button_checked_outlined
                    : Icons.radio_button_off, color: AppColors.orange),
                const SizedBox(width: 8),
                Text(status.name.capitalizeFirst!, style: TextStyles.bodyL),
              ],
            ),
          ),
        ));
  }

  Widget _itemTitle(String label, IconData iconData) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        appIcon(iconData),
        const SizedBox(width: 8),
        Text(label, style: TextStyles.titleM),
      ],
    );
  }

  Widget _saveOrCancel() {
    return Container(
      padding: const EdgeInsets.only(left: 24),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(label: 'Submit', colorBg: AppColors.orange, onPressed: _save),
          const AppButton(
              label: 'Cancel',
              primary: false,
              colorBg: AppColors.secondary_60),
        ],
      ),
    );
  }

  Widget _jobDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Job Description",
          style: TextStyle(
            color: AppColors.dark_1,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 128,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.light_3,
                width: 1,
              )),
          child: TextFormField(
            controller: _descriptionController,
            keyboardAppearance: Brightness.light,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(border: InputBorder.none),
            maxLength: null,
            maxLines: null,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.dark_3,
            ),
          ),
        ),
      ],
    );
  }

  void _save() async {
    JobModel model = JobModel(status: _status.value.name,
        customerId: _customerId.value,
        jobId: Random().nextInt(9000)+ 1000,
        description: _descriptionController.text,
        jobType: _jobType.value!);

    model.objectId = jobModel?.objectId;
    final response =
        await controller.save(model);
    String msg;
    if (response is String) {
      msg = response;
    } else {
      NavigationController().pop(Get.context!, delay: 1);
      msg = "Saved Customer!";
    }
    // WarningMessageDialog.showDialog(Get.context!, msg);
  }
}
