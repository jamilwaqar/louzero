import 'dart:developer';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_country_picker.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/countries.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/layout.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({this.model, Key? key}) : super(key: key);
  final CustomerModel? model;

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final _authController = Get.find<AuthController>();
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
  late String? _customerType = _authController.user.customerTypes[0];
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
      _overlayTest(),
      _customerDetails(),
      _serviceAddress(),
      _billingAddress(),
      ..._customerContactList,
      _formButtons(),
    ];
    return Column(
      children: list,
    );
  }

  Widget _customerDetails() {
    return AppCard(
      children: [
        Ui.headingLG('Customer Details', MdiIcons.account),
        FlexRow(
          children: [
            AppTextField(
                controller: _companyNameController,
                label: "Company or Account Name"),
            AppDropDown(
              label: "Customer Type*",
              itemList: _authController.user.customerTypes,
              initValue: _customerType,
              onChanged: (value) {
                setState(() {
                  _customerType = value;
                });
              },
            ),
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
    );
  }

  Widget _parentAccount() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppDivider(),
        AppTextField(
            controller: _parentAccountNameController,
            label: "Parent Account Name"),
      ],
    );
  }

  Widget _serviceAddress() {
    return AppCard(
      clip: false,
      children: [_addressWidget(true)],
    );
  }

  Widget _overlayTest() {
    return AppCard(children: [
      Buttons.primary('Overlay Test', expanded: true, onPressed: () {
        Overlay.of(context)?.insert(_addressOverlay());
      }),
    ]);
  }

  OverlayEntry _addressOverlay() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 400,
        // top: offset.dy + size.height + 5.0,
        // left: offset.dx,
        // top: offset.dy + size.height + 5.0,
        // width: size.width,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(24),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
              Text('Option', style: AppStyles.labelBold),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addressWidget(bool isService) {
    return Stack(clipBehavior: Clip.none, children: [
      Wrap(children: [
        AppCountryPicker(
          defaultCountryCode: 'us',
          onChange: (val) {
            print('Country Changed: $val');
          },
        ),
        const SizedBox(height: 16),
        FlexRow(
          children: [
            AppTextField(
              controller:
                  isService ? _serviceStreetController : _billStreetController,
              label: "Street Address",
              onChanged: (val) {
                _baseController.searchAddress(val, _country.countryCode);
              },
            )
          ],
        ),
        FlexRow(
          children: [
            AppTextField(
              controller:
                  isService ? _serviceAptController : _billAptController,
              label: "Apt / Suite / Other",
            ),
          ],
        ),
        FlexRow(
          children: [
            AppTextField(
                controller:
                    isService ? _serviceCityController : _billCityController,
                label: "City"),
            AppTextField(
                controller:
                    isService ? _serviceStateController : _billStateController,
                label: "State"),
            AppTextField(
                controller:
                    isService ? _serviceZipController : _billZipController,
                label: "Zip"),
          ],
        ),
        Buttons.link(
          "Enter Address Fields Manually",
          onPressed: () {},
        ),
      ]),
      AddressList(
        left: 0,
        right: 0,
        top: 180,
        onSelectedSearchedModel: (model) {
          if (isService) {
            _serviceSearchAddressModel = model;
          } else {
            _billSearchAddressModel = model;
          }
          if (isService) {
            _serviceStreetController.text = model.street ?? '';
            _serviceCityController.text = model.city ?? '';
            _serviceStateController.text = model.state;
          } else {
            _billStreetController.text = model.street ?? '';
            _billCityController.text = model.city ?? '';
            _billStateController.text = model.state;
          }
          setState(() {});
        },
      ),
    ]);
  }

  Widget _billingAddress() {
    return AppCard(
      clip: false,
      pb: _sameAsService ? 0 : 24,
      children: [
        RowSplit(
            left: Row(
              children: [
                Ui.headingLG('Billing Address', MdiIcons.mapMarker),
              ],
            ),
            right: NZSwitch(
                isOn: _sameAsService,
                label: "Same as Service Address",
                onChanged: (val) {
                  setState(() {
                    _sameAsService = val;
                  });
                })),
        if (!_sameAsService) _addressWidget(false),
      ],
    );
  }

  Widget _customerContact(int index) {
    return AppCard(
      children: [
        Ui.headingLG('Customer Contact', MdiIcons.contacts),
        const SizedBox(height: 24),
        _contactTypeRow(index),
        FlexRow(
          children: [
            AppTextField(
              controller: _contactFNameControllers[index],
              label: "First Name",
            ),
            AppTextField(
              controller: _contactLNameControllers[index],
              label: "Last Name",
            )
          ],
        ),
        FlexRow(
          children: [
            AppTextField(
                controller: _contactEmailControllers[index],
                label: "Email Address"),
            AppTextField(
                controller: _contactPhoneControllers[index],
                label: "Phone Number"),
          ],
        ),
        FlexRow(
          children: [
            AppTextField(
                controller: _contactRoleControllers[index], label: "Role"),
          ],
        ),
      ],
    );
  }

  Widget _contactTypeRow(int index) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondary_99,
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Wrap(
            runSpacing: 24,
            children: [
              _contactTypeItem(index, CTContactType.primary),
              _contactTypeItem(index, CTContactType.billing),
              _contactTypeItem(index, CTContactType.schedule),
              _contactTypeItem(index, CTContactType.other),
            ],
          )
        ],
      ),
    );
  }

  Widget _contactTypeItem(int index, CTContactType type) {
    List<CTContactType> types = _contactTypes[index];
    return GestureDetector(
      onTap: () => _onChangedContactType(index, type),
      child: Column(
        children: [
          AppCheckboxLabel(
            onChanged: (val) => _onChangedContactType(index, type),
            value: types.contains(type),
            label: type.name,
          )
        ],
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

  Widget _formButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Buttons.outline(
            'Add Another Contact',
            onPressed: _addContact,
            icon: MdiIcons.plusCircle,
            colorBg: AppColors.white,
          ),
          const AppDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Buttons.primary('Save Customer', onPressed: _save),
              Buttons.text('cancel', onPressed: () {
                NavigationController().pop(context);
              })
            ],
          ),
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
}

class AppCheckboxLabel extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool value;
  final String label;

  const AppCheckboxLabel(
      {required this.onChanged,
      required this.value,
      required this.label,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            checkColor: Colors.white,
            value: value,
            activeColor: AppColors.primary_1,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppStyles.labelRegular),
        const SizedBox(width: 24),
      ],
    );
  }
}
