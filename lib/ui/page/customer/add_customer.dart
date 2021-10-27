import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/models.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
import 'package:louzero/ui/widget/side_menu/sub_app_bar.dart';
import 'package:louzero/ui/widget/switch_button.dart';
import 'package:louzero/ui/widget/textfield/text_field.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController = TextEditingController();
  bool _subAccount = false;
  CTContactType? _contactType;

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Add New Customer",
          context: context,
          leadingTxt: "Customer",
        ),
        backgroundColor: AppColors.light_1,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),
      children: [
        _customerDetails(),
        const SizedBox(height: 24),
        _serviceAddress(),
        const SizedBox(height: 24),
        _billingAddress(),
        const SizedBox(height: 24),
        _customerContact(),
        const SizedBox(height: 24),
      ],
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
        children: [
          _itemTitle("Customer Details", Icons.person),
          const SizedBox(height: 32),
          Row(
            children: [
              Flexible(child: NZTextField(controller: _companyNameController, label: "Company or Account Name")),
              const SizedBox(width: 32),
              Flexible(child: NZTextField(controller: _companyNameController, label: "Customer Type")),
            ],
          ),
          const SizedBox(height: 24),
          NZSwitch(isOn: _subAccount, label: "Sub-Account of another customer", onChanged: (val) {
            setState(() {
              _subAccount = val;
            });
          }),
          if (_subAccount)
          _parentAccount(),
        ],
      ),
    );
  }

  Widget _parentAccount() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        const Divider(indent: 25, endIndent: 25),
        const SizedBox(height: 24),
        Row(
          children: [
            Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Parent Account Name")),
            const SizedBox(width: 32),
            const Flexible(child: SizedBox()),
          ],
        ),
      ],
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
          _itemTitle("Service Address", Icons.location_pin),
          const SizedBox(height: 32),
          Row(
            children: [
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Country")),
              const SizedBox(width: 32),
              const Flexible(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 24),
          NZTextField(controller: _parentAccountNameController, label: "Street Address"),
          const SizedBox(height: 16),
          NZTextField(controller: _parentAccountNameController, label: "Apartment, unit, suite, or floor #"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "City")),
              const SizedBox(width: 16),
              Flexible(
                child: Row(
                  children: [
                    Flexible(child: NZTextField(controller: _parentAccountNameController, label: "State")),
                    const SizedBox(width: 16),
                    Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Zip")),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LZTextButton(
            "Enter Address Fields Manually",
            textDecoration: TextDecoration.underline,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _billingAddress() {
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
          const Text("Billing Address", style: TextStyles.nav20),
          const SizedBox(height: 16),
          NZSwitch(isOn: _subAccount, label: "Sub-Account of another customer", onChanged: (val) {
            setState(() {
              _subAccount = val;
            });
          }),
        ],
      ),
    );
  }

  Widget _customerContact() {
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
          _itemTitle("Service Address", Icons.contacts),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "First Name")),
              const SizedBox(width: 32),
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Last Name")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Email Address")),
              const SizedBox(width: 32),
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Phone Number")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: NZTextField(controller: _parentAccountNameController, label: "Role")),
              const SizedBox(width: 32),
              const Flexible(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(indent: 25, endIndent: 25),
          const SizedBox(height: 24),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     _optionItem(CTContactType.primary),
          //     _optionItem(CTContactType.billing),
          //     _optionItem(CTContactType.schedule),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _optionItem(CTContactType type) => Container(
    height: 35,
    child: CheckboxListTile(
        title: Text(type.name,
            style: TextStyles.text16),
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: Colors.white,
        value: type == _contactType,
        onChanged: (val) {
          setState(() {
            _contactType = type;
          });
        }),
  );

  Widget _itemTitle(String label, IconData iconData) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        appIcon(iconData),
        const SizedBox(width: 8),
        Text(label, style: TextStyles.nav20),
      ],
    );
  }
}
