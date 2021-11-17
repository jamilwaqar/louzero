import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/common/app_drop_down.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:uuid/uuid.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage(this._customerBloc, {Key? key}) : super(key: key);

  final CustomerBloc _customerBloc;

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController = TextEditingController();

  final TextEditingController _serviceCountryController = TextEditingController();
  final TextEditingController _serviceStreetController = TextEditingController();
  final TextEditingController _serviceCityController = TextEditingController();
  final TextEditingController _serviceAtController = TextEditingController();
  final TextEditingController _serviceStateController = TextEditingController();
  final TextEditingController _serviceZipController = TextEditingController();

  final TextEditingController _billCountryController = TextEditingController();
  final TextEditingController _billStreetController = TextEditingController();
  final TextEditingController _billCityController = TextEditingController();
  final TextEditingController _billAtController = TextEditingController();
  final TextEditingController _billStateController = TextEditingController();
  final TextEditingController _billZipController = TextEditingController();

  final List<TextEditingController> _contactFNameControllers = [TextEditingController()];
  final List<TextEditingController> _contactLNameControllers = [TextEditingController()];
  final List<TextEditingController> _contactEmailControllers = [TextEditingController()];
  final List<TextEditingController> _contactPhoneControllers = [TextEditingController()];
  final List<TextEditingController> _contactRoleControllers = [TextEditingController()];

  bool _subAccount = false;
  bool _sameAsService = true;
  final List<Widget> _customerContactList = [];
  final List<String> _mockCustomerType = ["Residential", "Commercial"];
  String? _customerType;
  List<List<CTContactType>> _contactTypes = [[]];

  @override
  void initState() {
    _customerContactList.add(_customerContact(0));
    _customerType = _mockCustomerType[0];
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    _serviceCountryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      bloc: widget._customerBloc,
      listener: (context, state) {

      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: widget._customerBloc,
        builder: (context, state) {
          return BaseScaffold(
            child: Scaffold(
              appBar: SubAppBar(
                title: "Add New Customer",
                context: context,
                leadingTxt: "Customer",
              ),
              backgroundColor: AppColors.light_1,
              body: _body(state),
            ),
          );
        }
      ),
    );
  }

  Widget _body(CustomerState state) {
    List<Widget> list = [
      _customerDetails(),
      const SizedBox(height: 24),
      _serviceAddress(),
      const SizedBox(height: 24),
      _billingAddress(),
      ... _customerContactList,
      const SizedBox(height: 24),
      _addContactWidget(),
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
              Flexible(child: AppDropDown(label: "Customer Type*",itemList: _mockCustomerType, initValue: _customerType, onChanged: (value){
                setState(() {
                  _customerType = value;
                });
              },)),
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
          _addressWidget(true),
        ],
      ),
    );
  }

  Widget _addressWidget(bool isService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(child: InkWell(
                onTap: _showCountryPicker,
                child: LZTextField(controller: isService ? _serviceCountryController : _billCountryController, label: "Country", enabled: false,))),
            const SizedBox(width: 32),
            const Flexible(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 24),
        LZTextField(controller: isService ? _serviceStreetController : _billStreetController, label: "Street Address"),
        const SizedBox(height: 16),
        LZTextField(controller: isService ? _serviceAtController : _billAtController, label: "Apt / Suite / Other"),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(child: LZTextField(controller: isService ? _serviceCityController : _billCityController, label: "City")),
            const SizedBox(width: 16),
            Flexible(
              child: Row(
                children: [
                  Flexible(child: LZTextField(controller: isService ? _serviceStateController : _billStateController, label: "State")),
                  const SizedBox(width: 16),
                  Flexible(child: LZTextField(controller: isService ? _serviceZipController : _billZipController, label: "Zip")),
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
          NZSwitch(isOn: _sameAsService, label: "Same as Service Address", onChanged: (val) {
            setState(() {
              _sameAsService = val;
            });
          }),
          if (!_sameAsService)
          _addressWidget(false),
        ],
      ),
    );
  }

  Widget _customerContact(int index) {
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
              Flexible(child: LZTextField(controller: _contactFNameControllers[index], label: "First Name")),
              const SizedBox(width: 32),
              Flexible(child: LZTextField(controller: _contactLNameControllers[index], label: "Last Name")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _contactEmailControllers[index], label: "Email Address")),
              const SizedBox(width: 32),
              Flexible(child: LZTextField(controller: _contactPhoneControllers[index], label: "Phone Number")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(child: LZTextField(controller: _contactRoleControllers[index], label: "Role")),
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
              _contactTypeItem(index, CTContactType.primary),
              _contactTypeItem(index, CTContactType.billing),
              _contactTypeItem(index, CTContactType.schedule),
              _contactTypeItem(index, CTContactType.other),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactTypeItem(int index, CTContactType type) {
    List<CTContactType> types = _contactTypes[index];
    return Container(
      height: 35,
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        onPressed: ()=> _onChangedContactType(index, type),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: types.contains(type),
                activeColor: AppColors.dark_1,
                onChanged: (val)=> _onChangedContactType(index, type)),
            Text(type.name, style: TextStyles.bodyL),
            if (type != CTContactType.schedule) const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  void _onChangedContactType(int index, type) {
    setState(() {
      if (_contactTypes[index].contains(type)) {
        _contactTypes[index].remove(type);
      } else {
        _contactTypes[index].add(type);
      }
    });
  }

  Widget _addContactWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        onPressed: _addContact,
        padding: EdgeInsets.zero,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8),
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

  void _addContact() {
    setState(() {
      _contactFNameControllers.add(TextEditingController());
      _contactLNameControllers.add(TextEditingController());
      _contactEmailControllers.add(TextEditingController());
      _contactPhoneControllers.add(TextEditingController());
      _contactRoleControllers.add(TextEditingController());
      _contactTypes.add([]);
      _customerContactList.add(_customerContact(_customerContactList.length));
    });
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

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          _serviceCountryController.text = country.name;
        });
        print('Select country: ${country.displayName}');
      },
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
    AddressModel billingAddress;
    AddressModel serviceAddress = AddressModel(
        country: _serviceCountryController.text,
        street: _serviceStreetController.text,
        city: _serviceCityController.text,
        state: _serviceStateController.text,
        zip: _serviceZipController.text);
    if (_sameAsService) {
      billingAddress = serviceAddress;
    } else {
      billingAddress = AddressModel(
          country: _billCountryController.text,
          street: _billStreetController.text,
          city: _billCityController.text,
          state: _billStateController.text,
          zip: _billZipController.text);
    }

    List<CustomerContact> contacts = [];


    CustomerModel model = CustomerModel(id: const Uuid().v4(),
        userId: const Uuid().v4(),
        companyId: const Uuid().v4(),
        name: _companyNameController.text,
        type: _customerType!,
        serviceAddress: serviceAddress,
        billingAddress: billingAddress);
    model.customerContacts = contacts;

    Map<String, dynamic> data = model.toJson();
    Backendless.data.of(BPath.customer).save(data).then(
            (response) => print("Object is saved in Backendless. Please check in the console."));
  }
}
