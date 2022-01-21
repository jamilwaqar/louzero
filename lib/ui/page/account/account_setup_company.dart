import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_checkbox.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_multiselect.dart';
import 'package:louzero/common/app_textfield.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/common/utility/address_list.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/layout.dart';
import 'package:louzero/controller/constant/list_state_names.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/widget/time_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

List<SelectItem> industries = const [
  SelectItem(id: '23', label: 'Residential', value: 'res'),
  SelectItem(id: '24', label: 'Commercial', value: 'com'),
  SelectItem(id: '25', label: 'Industrial', value: 'ind'),
  SelectItem(id: '26', label: 'Public', value: 'pub'),
  SelectItem(id: '27', label: 'Government', value: 'gov'),
  SelectItem(id: '28', label: 'Entertainment', value: 'res'),
  SelectItem(id: '29', label: 'Non Profit', value: 'com'),
  SelectItem(id: '31', label: 'Rural', value: 'pub'),
  SelectItem(id: '32', label: 'Scientific', value: 'gov'),
];

class AccountSetupCompany extends StatefulWidget {
  const AccountSetupCompany({
    this.companyModel,
    this.onChange,
    this.isFromAccountSetup = false,
    Key? key,
  }) : super(key: key);

  final void Function()? onChange;
  final CompanyModel? companyModel;
  final bool isFromAccountSetup;

  @override
  State<AccountSetupCompany> createState() => _AccountSetupCompanyState();
}

class _AccountSetupCompanyState extends State<AccountSetupCompany> {
  final _formKey = GlobalKey<FormState>();

  CompanyModel _companyModel = CompanyModel();
  AddressModel _addressModel =
      AddressModel(country: '', street: '', city: '', state: '', zip: '');

  final _companyNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _webController = TextEditingController();

  final _countryController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _suiteController = TextEditingController();
  final _zipController = TextEditingController();
  final _invoiceHeaderController = TextEditingController();
  final _idStartNumberController = TextEditingController();
  final _startTimeController = TextEditingController();

  Country _selectCountry = AppDefaultValue.country;
  late bool _isEdit;
  bool _isActiveCompany = false;
  SearchAddressModel? _searchAddressModel;
  final BaseController _baseController = Get.find();
  List<SelectItem> _initialIndustries = [
    industries[0],
    industries[1],
    industries[4]
  ];

  @override
  void initState() {
    String mockDataInvoicHeader =
        "Thumbtack Pool Cleaner \n 1234 Street St., Vancouver, Washington 98607 \n www.thumbtackpoolcleaners.com \n\n info@thumbtackpoolcleaners.com \n 1 (360) 936-7594 ";

    _invoiceHeaderController.text = mockDataInvoicHeader;

    _isEdit =
        widget.companyModel != null && widget.companyModel!.objectId != null;
    _isActiveCompany = widget.isFromAccountSetup;
    if (_isEdit) {
      _companyModel = widget.companyModel!;
      _addressModel = widget.companyModel!.address!;
      _companyNameController.text = _companyModel.name;
      _phoneController.text = _companyModel.phone;
      _emailController.text = _companyModel.email;
      _webController.text = _companyModel.website;
      _countryController.text = _addressModel.country;
      _streetController.text = _addressModel.street;
      _cityController.text = _addressModel.city;
      _stateController.text = _addressModel.state;
      _suiteController.text = _addressModel.suite;
      _zipController.text = _addressModel.zip;
      _initialIndustries = industries
          .where((element) => _companyModel.industries.contains(element.label))
          .toList();
      _isActiveCompany =
          _companyModel.objectId == _baseController.activeCompany!.objectId;
    } else {
      _countryController.text = _selectCountry.name;
      _companyModel.industries =
          _initialIndustries.map((e) => e.value).toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    _baseController.searchedAddressList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppCard(
              children: [
                Ui.headingLG('Company Details', MdiIcons.homeCity),
                if (_isActiveCompany)
                  FlexRow(
                    flex: [2, 2],
                    children: [
                      Column(
                        children: [
                          _companyName(),
                          _website(),
                        ],
                      ),
                      Column(
                        children: [
                          _email(),
                          _phone(),
                        ],
                      )
                    ],
                  ),
                if (!_isActiveCompany)
                  FlexRow(
                    flex: [2, 3],
                    children: [
                      Column(
                        children: [
                          AppNetworkImage(uri: _companyModel.avatar),
                          SizedBox(height: 16),
                          Buttons.outline('Update Logo', onPressed: () {
                            //Upload Logo
                          }),
                        ],
                      ),
                      Column(
                        children: [
                          _companyName(),
                          _website(),
                          _email(),
                          _phone()
                        ],
                      )
                    ],
                  ),
                const AppDivider(
                  mt: 16,
                  mb: 24,
                  color: AppColors.light_2,
                ),
                Ui.headingLG('Industries', MdiIcons.domain, mb: 16),
                _tags(),
              ],
            ),
            AppCard(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ui.headingLG('Company Address', MdiIcons.domain),
                        _country(),
                        _street(),
                        _suite(),
                        Row(
                          children: [
                            expand(_city(), 4),
                            gapX(24),
                            expand(_state(), 3),
                            gapX(24),
                            expand(_zip(), 2),
                          ],
                        ),
                      ],
                    ),
                    AddressList(
                        left: 0,
                        right: 0,
                        top: 225,
                        onSelectedSearchedModel: (val) {
                          _searchAddressModel = val;
                          _streetController.text = val.street ?? '';
                          _cityController.text = val.city ?? '';
                          _stateController.text = val.state;
                          setState(() {});
                        }),
                  ],
                ),
                if (!_isActiveCompany) const SizedBox(height: 24),
                if (!_isActiveCompany)
                  AppCheckbox(
                    label: 'Active Company',
                    checked: _isActiveCompany,
                    onChanged: (val) {
                      setState(() {
                        _isActiveCompany = val ?? true;
                      });
                    },
                  ),
              ],
            ),
            // Don't show in initial sigup steps flow:
            if (!_isActiveCompany) ..._fullEditForm(),
            Row(
              children: [
                SizedBox(width: 32),
                Wrap(
                  children: [
                    Buttons.primary(
                      'Save & Continue',
                      onPressed: _submit,
                    ),
                    Buttons.text(
                      'Cancel',
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 200)
          ],
        ));
  }

  List<Widget> _fullEditForm() {
    return [
      AppCard(
        children: [
          Ui.headingLG('Invoice Header', MdiIcons.briefcase, mb: 16),
          SizedBox(
            height: 200,
            child: AppTextField(
              multiline: true,
              mb: 0,
              expands: true,
              height: 200,
              controller: _invoiceHeaderController,
              label: 'Invoice Header',
            ),
          ),
        ],
      ),
      AppCard(
        children: [
          Ui.headingLG('Job Settings', MdiIcons.clipboardText),
          FlexRow(
            children: [
              AppTextField(
                label: 'ID Starting Number',
                controller: _idStartNumberController,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NZTimePicker(onChange: (val) {
                          _startTimeController.text = val;
                        });
                      });
                },
                child: AppTextField(
                  label: 'Schedule start Time',
                  controller: _startTimeController,
                  iconEnd: MdiIcons.clockOutline,
                  enabled: false,
                ),
              ),
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
        child: Row(
          children: [
            Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 10,
              children: [
                Buttons.outline(
                  "Cancel Company",
                  icon: MdiIcons.cancel,
                  colorBg: Colors.white,
                ),
                Buttons.outline(
                  "Transfer Ownership",
                  icon: MdiIcons.swapHorizontal,
                  colorBg: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      AppDivider(size: 2, ml: 32, mr: 32, mb: 24, mt: 24)
    ];
  }

  Widget expand(Widget child, [flex = 1]) {
    return Expanded(child: child, flex: flex);
  }

  Widget _cardHeader(String label, IconData icon,
      {VoidCallback? ontap, double mb = 24}) {
    return AppHeaderIcon(
      label.toUpperCase(),
      iconStart: icon,
      onTap: ontap,
      mb: mb,
      style: AppStyles.headerRegular
          .copyWith(color: AppColors.secondary_30, fontSize: 20),
    );
  }

  void _submit() async {
    bool valid = _formKey.currentState!.validate();
    if (!valid) return;
    _formKey.currentState!.save();
    _addressModel.latitude = _searchAddressModel?.latitude ?? 0;
    _addressModel.longitude = _searchAddressModel?.longitude ?? 0;
    await Get.find<CompanyController>().createOrEditCompany(_companyModel,
        addressModel: _addressModel,
        isEdit: _isEdit,
        isActiveCompany: _isActiveCompany);
    if (widget.onChange != null) widget.onChange!();
    if (_isEdit || !widget.isFromAccountSetup) Get.back();
  }

  // Validation:
  String? _validatePhone(String? value) {
    RegExp regex = RegExp('^(?:[+0]9)?[0-9]{10}\$');
    if (value != null && value.isEmpty) {
      return 'Phone Number is required';
    }
    if (value != null && !regex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }

  String? _validateName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Name is required';
    } else {
      return null;
    }
  }

  _phone() => AppTextField(
        controller: _phoneController,
        required: true,
        label: 'Phone Number',
        keyboardType: TextInputType.phone,
        validator: _validatePhone,
        onSaved: (val) {
          _companyModel.phone = val ?? '';
        },
      );

  _companyName() => AppTextField(
        controller: _companyNameController,
        required: true,
        label: 'Company Name',
        validator: _validateName,
        onSaved: (val) {
          _companyModel.name = val ?? '';
        },
      );

  _website() => AppTextField(
        controller: _webController,
        label: 'Website',
        onSaved: (val) {
          _companyModel.website = val ?? '';
        },
      );

  _email() => AppTextField(
        controller: _emailController,
        label: 'Email Address',
        required: true,
        onSaved: (val) {
          _companyModel.email = val ?? '';
        },
      );
  _tags({bool showLabel = false}) => AppMultiSelect(
        initialItems: _initialIndustries,
        showLabel: showLabel,
        items: industries,
        onChange: (items) {
          _initialIndustries = items;
          _companyModel.industries = items.map((e) => e.label).toList();
        },
        label: 'What Industries do you Serve?',
      );
  _country() => InkWell(
        onTap: () => countryPicker(context, (country) {
          _selectCountry = country;
          setState(() {
            _countryController.text = country.name;
          });
        }),
        child: AppTextField(
          label: 'Country',
          enabled: false,
          controller: _countryController,
          onSaved: (val) {
            _addressModel.country = val ?? '';
          },
        ),
      );

  _street() => AppTextField(
        label: 'Street',
        controller: _streetController,
        onSaved: (val) {
          _addressModel.street = val ?? '';
        },
        onChanged: (val) {
          _baseController.searchAddress(val, _selectCountry.countryCode);
        },
      );
  _suite() => AppTextField(
        controller: _suiteController,
        label: 'Suite',
        onSaved: (val) {
          _addressModel.suite = val ?? '';
        },
      );

  _city() => AppTextField(
        label: 'City',
        controller: _cityController,
        onSaved: (val) {
          _addressModel.city = val ?? '';
        },
      );

  _state() => AppTextField(
        label: 'State',
        controller: _stateController,
        options: listStateNames,
        onSaved: (val) {
          _addressModel.state = val ?? '';
        },
      );
  _zip() => AppTextField(
        controller: _zipController,
        label: 'Zip',
        onSaved: (val) {
          _addressModel.zip = val ?? '';
        },
      );

  // Utility Functions
  Widget gapX(double gap) {
    return SizedBox(width: gap);
  }

  Widget gapY(double gap) {
    return SizedBox(height: gap);
  }
}
