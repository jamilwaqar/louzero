import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/common/app_multiselect.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/list_state_names.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';

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
    Key? key,
    this.onChange,
  }) : super(key: key);

  final void Function()? onChange;


  @override
  State<AccountSetupCompany> createState() => _AccountSetupCompanyState();
}



class _AccountSetupCompanyState extends State<AccountSetupCompany> {
  final _formKey = GlobalKey<FormState>();

  final CompanyModel _companyModel = CompanyModel();
  final AddressModel _addressModel = AddressModel(country: '', street: '', city: '', state: '', zip: '');
  final _countryController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  SearchAddressModel? _searchAddressModel;
  final BaseController _baseController = Get.find();
  List<SelectItem> _industries = [industries[0], industries[1], industries[4]];


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AppCard(
              children: [
                const AppTextHeader(
                  'Company Details',
                  alignLeft: true,
                  icon: Icons.home_work_sharp,
                  size: 24,
                ),
                Row(
                  children: [
                    expand(_companyName()),
                    gapX(24),
                    expand(_phone())
                  ],
                ),
                Row(
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
                _tags(),
              ],
            ),
            AppCard(
              children: [
                const AppTextHeader(
                  'Company Address',
                  alignLeft: true,
                  icon: Icons.location_on,
                  size: 24,
                ),
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
            Row(
              children: [
                AppButton(
                  margin: const EdgeInsets.only(left: 24, bottom: 64),
                  label: 'Save & Continue',
                  onPressed: _submit,
                ),
              ],
            ),
          ],
        ));
  }

  Widget expand(Widget child, [flex = 1]) {
    return Expanded(child: child, flex: flex);
  }

  void _submit() {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      _formKey.currentState!.save();
      if (widget.onChange != null) widget.onChange!();
    }
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

  _phone() => AppInputText(
        required: true,
        label: 'Phone Number',
        keyboardType: TextInputType.phone,
        validator: _validatePhone,
        onSaved: (val) {
          _companyModel.phone = val ?? '';
        },
      );

  _companyName() => AppInputText(
        required: true,
        label: 'Company Name',
        validator: _validateName,
        onSaved: (val) {
          _companyModel.name = val ?? '';
        },
      );

  _website() => AppInputText(
        label: 'Website',
        onSaved: (val) {
          _companyModel.website = val ?? '';
        },
      );

  _email() => AppInputText(
        label: 'Email Address',
        required: true,
        onSaved: (val) {
          _companyModel.email = val ?? '';
        },
      );
  _tags() => AppMultiSelect(
        width: 448,
        initialItems: _industries,
        items: industries,
        onChange: (items) {
          inspect(items);
          _industries = items;
        },
        label: 'What Industries do you Serve?',
      );
  _country() => InkWell(
    onTap: ()=> countryPicker(context, (country) {
      setState(() {
        _countryController.text = country.name;
      });
    }),
    child: AppInputText(
          label: 'Country',
          enabled: false,
          controller: _countryController,
          onSaved: (val) {
            _addressModel.country = val ?? '';
          },
        ),
  );
  _street() => Stack(
    children: [
      AppInputText(
            label: 'Street',
            onSaved: (val) {
              _addressModel.street = val ?? '';
            },
        onChanged: (val) {
              _baseController.searchAddress(val, 'US');
        },
          ),
      Positioned(
          left: 0, right: 0, top: 180, child: _searchedAddressListView()),
    ],
  );
  _suite() => AppInputText(
        label: 'Suite',
        onSaved: (val) {
          _addressModel.suite = val;
        },
      );
  _city() => AppInputText(
        label: 'City',
        onSaved: (val) {
          _addressModel.city = val ?? '';
        },
      );
  _state() => AppInputText(
        label: 'State',
        options: listStateNames,
        onSaved: (val) {
          _addressModel.state = val ?? '';
        },
      );
  _zip() => AppInputText(
        label: 'Zip',
        onSaved: (val) {
          _addressModel.zip = val ?? '';
        },
      );

  Widget _searchedAddressListView() {
    return Obx(() => _baseController.searchedAddresses.value.isEmpty
        ? Container()
        : Container(
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
          ));
  }

  Widget _searchAddressItem(int index) {
    SearchAddressModel model =_baseController.searchedAddresses.value[index];
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
  void _onSelectAddress(SearchAddressModel model, {bool isService = true}) async {
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
