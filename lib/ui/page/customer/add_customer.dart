import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';


class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController = TextEditingController();
  bool _subAccount = false;
  bool _billAddressEnabled = true;
  CTContactType? _contactType;
  final List<Widget> _customerContactList = [];

  @override
  void initState() {
    _customerContactList.add(_customerContact());
    super.initState();
  }

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
    List<Widget> list = [
      _customerDetails(),
      const SizedBox(height: 24),
      _serviceAddress(),
      const SizedBox(height: 24),
      _billingAddress(),
      ... _customerContactList,
      const SizedBox(height: 24),
      _addContact(),
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
        children: [
          _itemTitle("Customer Details", Icons.person),
          const SizedBox(height: 32),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _companyNameController, label: "Company or Account Name")),
              const SizedBox(width: 32),
              Flexible(child: LZTextField(controller: _companyNameController, label: "Customer Type*")),
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
            Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Parent Account Name")),
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
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Country")),
              const SizedBox(width: 32),
              const Flexible(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 24),
          LZTextField(controller: _parentAccountNameController, label: "Street Address"),
          const SizedBox(height: 16),
          LZTextField(controller: _parentAccountNameController, label: "Apartment, unit, suite, or floor #"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "City")),
              const SizedBox(width: 16),
              Flexible(
                child: Row(
                  children: [
                    Flexible(child: LZTextField(controller: _parentAccountNameController, label: "State")),
                    const SizedBox(width: 16),
                    Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Zip")),
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
          const Text("Billing Address", style: TextStyles.titleM),
          const SizedBox(height: 16),
          NZSwitch(isOn: _billAddressEnabled, label: "Sub-Account of another customer", onChanged: (val) {
            setState(() {
              _billAddressEnabled = val;
            });
          }),
        ],
      ),
    );
  }

  Widget _customerContact() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemTitle("Custom Contact", Icons.contacts),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "First Name")),
              const SizedBox(width: 32),
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Last Name")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Email Address")),
              const SizedBox(width: 32),
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Phone Number")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _parentAccountNameController, label: "Role")),
              const SizedBox(width: 32),
              const Flexible(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(indent: 25, endIndent: 25),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _contactTypeItem(CTContactType.primary),
              _contactTypeItem(CTContactType.billing),
              _contactTypeItem(CTContactType.schedule),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactTypeItem(CTContactType type) => Container(
        height: 35,
        alignment: Alignment.centerLeft,
        child: CupertinoButton(
          onPressed: () {
            setState(() {
              _contactType = type;
            });
          },
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  value: type == _contactType,
                  activeColor: AppColors.dark_1,
                  onChanged: (val) {
                    setState(() {
                      _contactType = type;
                    });
                  }),
              const SizedBox(width: 8),
              Text(type.name, style: TextStyles.bodyL),
              if (type != CTContactType.schedule) const SizedBox(width: 32),
            ],
          ),
        ),
      );

  Widget _addContact() {
    return Container(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            _customerContactList.add(_customerContact());
          });
        },
        padding: EdgeInsets.zero,
        child: Container(
          height: 36,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.light_4,
            borderRadius: BorderRadius.circular(18)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appIcon(Icons.add_circle, color: AppColors.medium_2),
              const SizedBox(width: 8),
              const Text("Add Another Contact", style: TextStyles.bodyL),
              const SizedBox(width: 16),
            ],
          ),
        ),
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
              child: Container(
                width: 192,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.dark_1,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text("SAVE CUSTOMER", style: TextStyles.bodyL.copyWith(color: Colors.white),),
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

  void _save() {

  }
}
