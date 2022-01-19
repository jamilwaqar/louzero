import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_checkbox.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_multiselect.dart';
import 'package:louzero/common/app_textfield.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/layout.dart';
import 'package:louzero/controller/constant/list_state_names.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';
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
  final _invoiceHeader = TextEditingController();

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
    String stuff =
        "Thumbtack Pool Cleaner \n 1234 Street St., Vancouver, Washington 98607 \n www.thumbtackpoolcleaners.com \n\n info@thumbtackpoolcleaners.com \n 1 (360) 936-7594 ";

    // _invoiceHeader.text = stuff;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    expand(_companyName()),
                    gapX(24),
                    expand(_phone())
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    expand(_email()),
                    gapX(24),
                    expand(_website()),
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
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 225,
                        child: _searchedAddressListView()),
                  ],
                ),
                const SizedBox(height: 24),
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
            ..._fullEditForm(),
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
          Ui.headingLG('Invoice Header', MdiIcons.clipboardText),
        ],
      ),
      AppCard(
        children: [
          Ui.headingLG('Job Settings', MdiIcons.briefcase),
          Ui.block(children: [
            Ui.text('Thumbtack Pool Cleaner'),
            Ui.text('1234 Street St., Vancouver, Washington 98607'),
            Ui.text('www.thumbtackpoolcleaners.com'),
            SizedBox(
              height: 24,
            ),
            Ui.text('info@thumbtackpoolcleaners.com'),
            Ui.text('1 (360) 936-7594'),
          ]),
          SizedBox(
            height: 200,
            child: AppTextField(
              multiline: true,
              expands: true,
              height: 200,
              controller: _invoiceHeader,
              label: 'Invoice Header',
            ),
          ),
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
                  icon: MdiIcons.star,
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

  Widget _searchedAddressListView() {
    return Obx(() {
      if (_baseController.searchedAddresses.value.isEmpty) {
        return Container();
      }
      return Container(
        padding: const EdgeInsets.all(8),
        height: 200,
        width: double.infinity,
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
    });
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
        _searchAddressModel = model;
      } else {
        _searchAddressModel = model;
      }

      List<String> arr = formattedAddress.split(',');
      if (arr.length > 2) {
        _streetController.text = arr[0];
        _cityController.text = arr[1];
        _stateController.text = model.state;
        setState(() {});
      }
    }
    _baseController.searchedAddressList = [];
    NavigationController().loading(isLoading: false);
  }

  // Utility Functions
  Widget gapX(double gap) {
    return SizedBox(width: gap);
  }

  Widget gapY(double gap) {
    return SizedBox(height: gap);
  }
}
