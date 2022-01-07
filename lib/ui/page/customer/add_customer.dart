import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_drop_down.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({this.model, Key? key}) : super(key: key);
  final CustomerModel? model;

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  late final TextEditingController _companyNameController =
      TextEditingController(text: widget.model?.companyName);
  late final TextEditingController _parentAccountNameController =
      TextEditingController(text: widget.model?.parentAccountName);

  late final TextEditingController _serviceCountryController =
      TextEditingController(
          text: widget.model?.billingAddress.country ??
              AppDefaultValue.country.name);
  late final TextEditingController _serviceStreetController =
      TextEditingController(text: widget.model?.serviceAddress.street);
  late final TextEditingController _serviceCityController =
      TextEditingController(text: widget.model?.serviceAddress.city);
  late final TextEditingController _serviceAptController =
      TextEditingController(text: widget.model?.serviceAddress.suite);
  late final TextEditingController _serviceStateController =
      TextEditingController(text: widget.model?.serviceAddress.state);
  late final TextEditingController _serviceZipController =
      TextEditingController(text: widget.model?.serviceAddress.zip);

  late final TextEditingController _billCountryController =
      TextEditingController(
          text: widget.model?.billingAddress.country ??
              AppDefaultValue.country.name);
  late final TextEditingController _billStreetController =
      TextEditingController(text: widget.model?.billingAddress.street);
  late final TextEditingController _billCityController =
      TextEditingController(text: widget.model?.billingAddress.city);
  late final TextEditingController _billAptController =
      TextEditingController(text: widget.model?.billingAddress.suite);
  late final TextEditingController _billStateController =
      TextEditingController(text: widget.model?.billingAddress.state);
  late final TextEditingController _billZipController =
      TextEditingController(text: widget.model?.billingAddress.zip);

  late final List<TextEditingController> _contactFNameControllers = [
    TextEditingController(text: widget.model?.customerContacts.first.firstName)
  ];
  late final List<TextEditingController> _contactLNameControllers = [
    TextEditingController(text: widget.model?.customerContacts.first.lastName)
  ];
  late final List<TextEditingController> _contactEmailControllers = [
    TextEditingController(text: widget.model?.customerContacts.first.email)
  ];
  late final List<TextEditingController> _contactPhoneControllers = [
    TextEditingController(text: widget.model?.customerContacts.first.phone)
  ];
  late final List<TextEditingController> _contactRoleControllers = [
    TextEditingController(text: widget.model?.customerContacts.first.role)
  ];

  late bool _subAccount = widget.model?.parentAccountName != null;

  late bool _sameAsService = widget.model?.billAddressSame ?? true;

  final List<Widget> _customerContactList = [];
  String? _customerType = AuthManager.userModel!.customerTypes[0];
  late final List<List<CTContactType>> _contactTypes = [
    widget.model?.customerContacts.first.types ?? []
  ];
  Country _country = AppDefaultValue.country;
  SearchAddressModel? _serviceSearchAddressModel;
  SearchAddressModel? _billSearchAddressModel;
  final BaseController _baseController = Get.find();
  final controller = Get.find<CustomerController>();

  @override
  void initState() {
    _customerContactList.add(_customerContact(0));
    if (widget.model != null) {
      CustomerModel model = widget.model!;
      _customerType = model.type;
      _serviceSearchAddressModel = SearchAddressModel()
        ..latitude = model.serviceAddress.latitude
        ..longitude = model.serviceAddress.longitude;
    }
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    _serviceCountryController.dispose();
    _baseController.searchedAddressList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: widget.model == null ? "Add New Customer" : "Edit Customer",
      child: _body(),
      footerEnd: [
        AppButton(
            label: 'Cancel',
            colorBg: AppColors.secondary_70.withAlpha(40),
            colorText: AppColors.secondary_70,
            onPressed: () {
              NavigationController().pop(context);
            })
      ],
    );
  }

  Widget _body() {
    List<Widget> list = [
      const SizedBox(height: 32),
      _customerDetails(),
      const SizedBox(height: 24),
      _serviceAddress(),
      const SizedBox(height: 24),
      _billingAddress(),
      ..._customerContactList,
      const SizedBox(height: 24),
      _addContactWidget(),
      const SizedBox(height: 32),
      const Divider(),
      const SizedBox(height: 32),
      _saveOrCancel(),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: list,
      ),
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
              Flexible(
                  child: LZTextField(
                      controller: _companyNameController,
                      label: "Company or Account Name")),
              const SizedBox(width: 32),
              Flexible(
                  child: AppDropDown(
                label: "Customer Type*",
                itemList: AuthManager.userModel!.customerTypes,
                initValue: _customerType,
                onChanged: (value) {
                  setState(() {
                    _customerType = value;
                  });
                },
              )),
            ],
          ),
          const SizedBox(height: 24),
          NZSwitch(
              isOn: _subAccount,
              label: "Sub-Account of another customer",
              onChanged: (val) {
                setState(() {
                  _subAccount = val;
                });
              }),
          if (_subAccount) _parentAccount(),
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
            Flexible(
                child: LZTextField(
                    controller: _parentAccountNameController,
                    label: "Parent Account Name")),
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
    return Obx(() => Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                        child: InkWell(
                            onTap: () => countryPicker(context, (country) {
                                  _country = country;
                                  setState(() {
                                    _serviceCountryController.text =
                                        country.name;
                                  });
                                }),
                            child: LZTextField(
                              controller: isService
                                  ? _serviceCountryController
                                  : _billCountryController,
                              label: "Country",
                              enabled: false,
                            ))),
                    const SizedBox(width: 32),
                    const Flexible(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 24),
                AppInputText(
                  controller: isService
                      ? _serviceStreetController
                      : _billStreetController,
                  label: "Street Address",
                  onChanged: (val) {
                    _baseController.searchAddress(val, _country.countryCode);
                  },
                ),
                AppInputText(
                    controller:
                        isService ? _serviceAptController : _billAptController,
                    label: "Apt / Suite / Other"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: LZTextField(
                            controller: isService
                                ? _serviceCityController
                                : _billCityController,
                            label: "City")),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                              child: LZTextField(
                                  controller: isService
                                      ? _serviceStateController
                                      : _billStateController,
                                  label: "State")),
                          const SizedBox(width: 16),
                          Flexible(
                              child: LZTextField(
                                  controller: isService
                                      ? _serviceZipController
                                      : _billZipController,
                                  label: "Zip")),
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
            Positioned(
                left: 0, right: 0, top: 180, child: _searchedAddressListView()),
          ],
        ));
  }

  Widget _billingAddress() {
    return Container(
      width: double.infinity,
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
          NZSwitch(
              isOn: _sameAsService,
              label: "Same as Service Address",
              onChanged: (val) {
                setState(() {
                  _sameAsService = val;
                });
              }),
          if (!_sameAsService) _addressWidget(false),
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
              Flexible(
                  child: LZTextField(
                      controller: _contactFNameControllers[index],
                      label: "First Name")),
              const SizedBox(width: 32),
              Flexible(
                  child: LZTextField(
                      controller: _contactLNameControllers[index],
                      label: "Last Name")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                  child: LZTextField(
                      controller: _contactEmailControllers[index],
                      label: "Email Address")),
              const SizedBox(width: 32),
              Flexible(
                  child: LZTextField(
                      controller: _contactPhoneControllers[index],
                      label: "Phone Number")),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                  child: LZTextField(
                      controller: _contactRoleControllers[index],
                      label: "Role")),
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
        onPressed: () => _onChangedContactType(index, type),
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                checkColor: Colors.white,
                value: types.contains(type),
                activeColor: AppColors.dark_1,
                onChanged: (val) => _onChangedContactType(index, type)),
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
      _customerContactList.removeAt(index);
      _customerContactList.add(_customerContact(index));
    });
  }

  Widget _addContactWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: AppAddButton("Add Another Contact", onPressed: _addContact),
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
                child: Text(
                  "SAVE CUSTOMER",
                  style: TextStyles.bodyL.copyWith(color: Colors.white),
                ),
              ),
              onPressed: _save),
          const SizedBox(width: 8),
          CupertinoButton(
              padding: EdgeInsets.zero,
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
    AddressModel billingAddress;
    AddressModel serviceAddress = AddressModel(
        country: _serviceCountryController.text,
        street: _serviceStreetController.text,
        city: _serviceCityController.text,
        state: _serviceStateController.text,
        zip: _serviceZipController.text);
    serviceAddress.suite = _serviceAptController.text;
    if (_serviceSearchAddressModel != null) {
      serviceAddress.latitude = _serviceSearchAddressModel!.latitude;
      serviceAddress.longitude = _serviceSearchAddressModel!.longitude;
    }
    if (_sameAsService) {
      billingAddress = serviceAddress;
    } else {
      billingAddress = AddressModel(
          country: _billCountryController.text,
          street: _billStreetController.text,
          city: _billCityController.text,
          state: _billStateController.text,
          zip: _billZipController.text);

      if (_serviceSearchAddressModel != null) {
        billingAddress.latitude = _billSearchAddressModel!.latitude;
        billingAddress.longitude = _billSearchAddressModel!.longitude;
      }
    }

    List<CustomerContact> contacts = [];
    for (int i = 0; i < _customerContactList.length; i++) {
      CustomerContact contact = CustomerContact(
          firstName: _contactFNameControllers[i].text,
          lastName: _contactLNameControllers[i].text,
          email: _contactEmailControllers[i].text,
          phone: _contactPhoneControllers[i].text,
          role: _contactRoleControllers[i].text);
      contact.types = _contactTypes[i];
      contacts.add(contact);
    }

    CustomerModel model = CustomerModel(
        companyName: _companyNameController.text,
        type: _customerType!,
        serviceAddress: serviceAddress,
        billingAddress: billingAddress);
    model.customerContacts = contacts;
    model.objectId = widget.model?.objectId;
    NavigationController().loading();
    final response =
        await controller.save(model, Backendless.data.of(BLPath.customer));
    String msg;
    if (response is String) {
      msg = response;
    } else {
      NavigationController().pop(Get.context!, delay: 2);
      msg = "Saved Customer!";
    }
    WarningMessageDialog.showDialog(Get.context!, msg);
    NavigationController().loading(isLoading: false);
  }

  Widget _searchedAddressListView() {
    if (_baseController.searchedAddresses.value.isEmpty) return Container();
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.light_1,
        border: Border.all(color: AppColors.dark_1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, int index) => _searchAddressItem(index),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: _baseController.searchedAddresses.value.length),
    );
  }

  Widget _searchAddressItem(int index) {
    SearchAddressModel model = _baseController.searchedAddresses.value[index];
    return InkWell(
      onTap: () => _onSelectAddress(model),
      child: Container(
        height: 42,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.location_pin, color: AppColors.dark_1, size: 32),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(model.description,
                    style: const TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            )),
            IconButton(
                icon: const Icon(Icons.save_outlined, color: AppColors.dark_1),
                onPressed: () {})
          ],
        ),
      ),
    );
  }

  void _onSelectAddress(SearchAddressModel model,
      {bool isService = true}) async {
    NavigationController().loading();
    List? res = await _baseController.getLatLng(model.placeId);
    if (res != null) {
      LatLng latLng = res[0];
      String formattedAddress = res[1];
      model.latitude = latLng.latitude;
      model.longitude = latLng.longitude;
      if (isService) {
        _serviceSearchAddressModel = model;
      } else {
        _billSearchAddressModel = model;
      }

      List<String> arr = formattedAddress.split(',');
      if (arr.length > 2) {
        if (isService) {
          _serviceStreetController.text = arr[0];
          _serviceCityController.text = arr[1];
          _serviceStateController.text = model.state;
        } else {
          _billStreetController.text = arr[0];
          _billCityController.text = arr[1];
          _billStateController.text = model.state;
        }
        setState(() {});
      }
    }
    _baseController.searchedAddressList = [];
    NavigationController().loading(isLoading: false);
  }
}
