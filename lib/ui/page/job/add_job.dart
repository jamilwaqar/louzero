import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);


  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController = TextEditingController();

  final TextEditingController _serviceCountryController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    _serviceCountryController.dispose();
    // widget.customerBloc.add(const SearchAddressEvent(''));
    super.dispose();
  }

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
      _customerDetails(),
      const SizedBox(height: 24),
      _serviceAddress(),
      const SizedBox(height: 32),
      const Divider(),
      const SizedBox(height: 32),
      _saveOrCancel(),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),
      children: list,
    );
  }

  Widget _customerDetails() {
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
          Row(
            children: [
              Flexible(child: AppInputText(controller: _companyNameController, label: "Select Customer")),
              const SizedBox(width: 32),
              Flexible(child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AppAddButton("Add New Customer", onPressed: () {  },),
              ),),
            ],
          )
        ],
      ),
    );
  }

  Widget _serviceAddress() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemTitle("Service Address", Icons.shopping_bag),
          const SizedBox(height: 32),
        ],
      ),
    );
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
                child: Text("SAVE JOB", style: TextStyles.bodyL.copyWith(color: Colors.white),),
              ),
              onPressed: _save),
          const SizedBox(width: 8),
          CupertinoButton(
              child: Container(
                width: 125,
                height: 56,
                alignment: Alignment.center,
                child: const Text("CANCEL", style: TextStyles.bodyL),
              ),
              onPressed: () {
                NavigationController().pop(context);
              }),
        ],
      ),
    );
  }

  void _save() async {
  }
}
