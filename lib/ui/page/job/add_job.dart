import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_drop_down.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/ui/widget/customer_info.dart';
import 'package:louzero/ui/widget/widget.dart';

enum SelectCustomerType {
  none,
  search,
  select
}

class AddJobPage extends GetWidget<JobController> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  final List<String> _mockJobType = ["Repair"];
  final List<String> _mockCustomerList = ["Test", "Mark"];
  final _status = JobStatus.estimate.obs;
  final _jobType = Rx<String?>(null);
  final _customerId = Rx<String?>(null);
  final _selectCustomerType = SelectCustomerType.none.obs;

  final BaseController _baseController = Get.find();

  AddJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Add New Job",
          context: context,
          leadingTxt: "Jobs",
        ),
        backgroundColor: Colors.transparent,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    List<Widget> list = [
      _addCustomer(),
      const SizedBox(height: 24),
      _jobDetailsWidget(),
      const SizedBox(height: 32),
      const Divider(),
      const SizedBox(height: 24),
      _saveOrCancel(),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),
      children: list,
    );
  }

  Widget _addCustomer() {
    return Obx(() => _customerId.value != null && tempCustomerModel != null
        ? CustomerInfo(tempCustomerModel!, fromJob: true,)
        : Container(
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
                        onPressed: () => Get.to(() => AddCustomerPage(
                            CustomerBloc(_baseController.customers.value))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
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
                            onTap: ()=> _selectCustomerType.value = SelectCustomerType.none,
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
    return Obx(()=> Container(
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
              Image.asset("assets/icons/icon-bag.png", width: 24, height: 24),
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
                    itemList: _mockJobType,
                    initValue: _jobType.value,
                    onChanged: (value) {
                      _jobType.value = value;
                    },
                  )),
              const SizedBox(width: 32),
              const Flexible(
                  child: SizedBox()),
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
          labelStyle:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.dark_3,
          ),
          errorStyle:
           TextStyle(color: Colors.redAccent, fontSize: 16.0),
          // hintText: hint,
        ),
        isEmpty: _customerId.value == null,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _customerId.value,
            isDense: true,
            onChanged: (val)=> _customerId.value = val,
            items: _mockCustomerList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _jobStatusItem(JobStatus status) {
    return Obx(()=> Container(
      height: 35,
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        onPressed: () => _status.value = status,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            appIcon(_status.value == status ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
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
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.dark_2,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text(
                  "SAVE JOB",
                  style: TextStyles.bodyL.copyWith(color: Colors.white),
                ),
              ),
              onPressed: ()=> controller.save()),
          const SizedBox(width: 8),
          CupertinoButton(
              child: Container(
                width: 125,
                height: 56,
                alignment: Alignment.center,
                child: const Text("CANCEL", style: TextStyles.bodyL),
              ),
              onPressed: () => Get.back()),
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
            decoration: const InputDecoration(
              border: InputBorder.none
            ),
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
}
