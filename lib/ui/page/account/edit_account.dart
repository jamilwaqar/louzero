import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/constant/list_state_names.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';

class EditAccountPage extends GetWidget<CompanyController> {
  EditAccountPage({Key? key}) : super(key: key);

  final _countryController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _suiteController = TextEditingController();
  final _zipController = TextEditingController();

  final BaseController _baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: const EdgeInsets.all(32),
        itemBuilder: (_, __) => _body(),
      ),
      subheader: 'Edit Account',
    );
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _accountInfo(),
        const Divider(height: 64, thickness: 1),
        Row(
          children: [
            AppButton(
              label: 'SAVE INFO',
              onPressed: () {},
            ),
            const SizedBox(
              width: 8,
            ),
            AppButton(
              label: 'CANCEL',
              primary: false,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  Widget _accountInfo() {
    return AppCard(
      radius: 16,
      pl: 0,
      pt: 0,
      pb: 0,
      pr: 0,
      mb: 0,
      ml: 0,
      mr: 0,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: 75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          appIcon(Icons.edit),
                          const SizedBox(width: 8),
                          Text('Edit Account',
                              style: TextStyles.headLineS
                                  .copyWith(color: AppColors.dark_2)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              color: AppColors.light_1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 246,
                    padding: const EdgeInsets.symmetric(vertical: 31),
                    decoration: const BoxDecoration(
                        color: AppColors.light_1,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8))),
                    child: _profile(),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Divider(
                                    thickness: 2, color: AppColors.light_1, height: 0),
                                const SizedBox(height: 24),
                                const AppInputText(label: 'Name', mb: 24),
                                const AppInputText(label: 'Phone', mb: 24),
                                const AppInputText(label: 'Email', mb: 24),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _country(),
                                        _street(),
                                        _suite(),
                                        _city(),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: _state(),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: _zip(),
                                            ),
                                            const Expanded(child: SizedBox())
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
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  _city() => AppInputText(
        label: 'City',
        controller: _cityController,
        onSaved: (val) {
          // _addressModel.city = val ?? '';
        },
      );

  _state() => AppInputText(
        label: 'State',
        controller: _stateController,
        options: listStateNames,
        onSaved: (val) {
          // _addressModel.state = val ?? '';
        },
      );

  _zip() => AppInputText(
        controller: _zipController,
        label: 'Zip',
        onSaved: (val) {
          // _addressModel.zip = val ?? '';
        },
      );

  _country() => InkWell(
        onTap: () => countryPicker(Get.context!, (country) {
          // _selectCountry = country;
          // setState(() {
          //   _countryController.text = country.name;
          // });
        }),
        child: AppInputText(
          label: 'Country',
          enabled: false,
          controller: _countryController,
          onSaved: (val) {
            // _addressModel.country = val ?? '';
          },
        ),
      );

  _street() => AppInputText(
        label: 'Street',
        controller: _streetController,
        onSaved: (val) {
          // _addressModel.street = val ?? '';
        },
        onChanged: (val) {
          // _baseController.searchAddress(val, _selectCountry.countryCode);
        },
      );

  _suite() => AppInputText(
        controller: _suiteController,
        label: 'Suite',
        onSaved: (val) {
          // _addressModel.suite = val ?? '';
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
      // if (isService) {
      //   _searchAddressModel = model;
      // } else {
      //   _searchAddressModel = model;
      // }

      List<String> arr = formattedAddress.split(',');
      if (arr.length > 2) {
        _streetController.text = arr[0];
        _cityController.text = arr[1];
        _stateController.text = model.state;
      }
    }
    _baseController.searchedAddressList = [];
    NavigationController().loading(isLoading: false);
  }

  Widget _profile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            AppAvatar(
                url: AuthManager.userModel!.avatar,
                text: AuthManager.userModel!.initials,
                size: 96,
                backgroundColor: AppColors.medium_2),
            Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.lightest, shape: BoxShape.circle),
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.medium_3, shape: BoxShape.circle),
                    child: const Icon(Icons.edit, color: AppColors.lightest, size: 14),
                  ),
                ))
          ],
        ),
        const SizedBox(height: 8),
        Text(AuthManager.userModel!.fullName,
            style: TextStyles.titleM.copyWith(fontWeight: FontWeight.bold, color: AppColors.dark_3)),
        const SizedBox(height: 8),
        Container(
          width: 64,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.medium_2,
              borderRadius: BorderRadius.circular(14)),
          child: Text('ADMIN',
              style: TextStyles.labelM.copyWith(color: AppColors.lightest)),
        ),
      ],
    );
  }
}
