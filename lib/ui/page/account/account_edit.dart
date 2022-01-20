import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/common/utility/address_list.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/constant/global_method.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class AccountEdit extends GetWidget<AuthController> {

  final _baseController = Get.find<BaseController>();
  late final _nameController = TextEditingController(text: controller.user.fullName);
  late final _phoneController = TextEditingController(text: controller.user.phone);
  late final _emailController = TextEditingController(text: controller.user.email);

  final _selectCountry = Rx<Country>(AppDefaultValue.country);
  late final _streetController =
  TextEditingController(text: controller.user.addressModel?.street);
  late final _cityController =
  TextEditingController(text: controller.user.addressModel?.city);
  late final _aptController =
  TextEditingController(text: controller.user.addressModel?.suite);
  late final _stateController =
  TextEditingController(text: controller.user.addressModel?.state);
  late final _zipController =
  TextEditingController(text: controller.user.addressModel?.zip);
  late final _countryController = TextEditingController(text: _selectCountry.value.name);
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  AccountEdit({Key? key}) : super(key: key);
  final _isEditContact = false.obs;
  toggleEdit() => _isEditContact.toggle();

  @override
  Widget build(BuildContext context) {
    return Obx(()=> AppCard(
      children: [
        AppHeaderIcon(
          !_isEditContact.value ? controller.user.fullName : 'Edit Account',
          icon: Icons.edit,
          iconStart: MdiIcons.accountCircle,
          onTap: () {
            toggleEdit();
            // Get.to(() => EditAccountPage(userModel));
          },
        ),
        const AppDivider(
          mt: 16,
          mb: 32,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(()=> AppAvatar(
                        url: controller.user.avatar,
                        text: controller.user.initials,
                        size: 136,
                        backgroundColor: AppColors.secondary_50,
                      )),
                      _uploadAvatar(),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Obx(()=> _editContact()),
            )
          ],
        ),
        const AppDivider(
          mt: 32,
        ),
        Obx(() {
          return RowSplit(
            left: _isEditContact.value
                ? Row(
              children: [
                Buttons.submit('Update Account', onPressed: _updateAccount),
                Buttons.text('cancel', onPressed: toggleEdit),
              ],
            )
                : null,
            right: Stack(
              children: [
                Buttons.lock(
                  'Change Password',
                  onPressed: () {
                    _showAlertDialog();
                  },
                ),
                if (_isEditContact.value)
                  Container(
                      color: Colors.white.withAlpha(200),
                      height: 41,
                      width: 200)
              ],
            ),
          );
        })
      ],
    ));
  }

  void _updateAccount() async {
    NavigationController().loading();
    String fullName = _nameController.text;
    List<String>names = fullName.split(' ');
    controller.user.firstname = names.first;
    controller.user.lastname = fullName.replaceAll('${names.first} ', '');

    controller.user.phone = _phoneController.text;
    controller.user.email = _emailController.text;
    AddressModel addressModel = AddressModel(
        country: _selectCountry.value.name,
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        suite: _aptController.text,
        zip: _zipController.text);
    controller.user.addressModel = addressModel;
    final response = await controller.updateUser();
    String msg = response is String ? response : 'Saved changes!';
    WarningMessageDialog.showDialog(Get.context!, msg);
    NavigationController().loading(isLoading: false);
    _isEditContact.value = false;
  }

  Widget _uploadAvatar() => Positioned(
      right: -20,
      bottom: -20,
      child: CupertinoButton(
        onPressed: () {
          controller.uploadAccountAvatar();
        },
        // padding: EdgeInsets.zero,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: AppColors.secondary_95, shape: BoxShape.circle),
          child: const Icon(Icons.edit, size: 14, color: AppColors.icon),
        ),
      ));

  Widget _editContact() {
    List<Widget> display = [
      _phoneDisplay(),
      _emailDisplay(),
      _addressDisplay(),
    ];

    List<Widget> edit = [
      _nameEdit(),
      _phoneEdit(),
      _emailEdit(),
      _addressEdit()
    ];

    return Obx(() {
      return Column(
        children: _isEditContact.value ? edit : display,
      );
    });
  }

  Widget _nameEdit() {
    return ColumnWithIconPrefix(
      icon: MdiIcons.accountCircle,
      children: [
        AppTextField(
          label: 'Name',
          controller: _nameController,
        ),
      ],
    );
  }

  Widget _phoneDisplay() {
    return AppIconLabelText(
        label: 'phone',
        text: controller.user.phone,
        hint: 'Add Phone Number.',
        icon: Icons.phone);
  }

  Widget _phoneEdit() {
    return ColumnWithIconPrefix(
      icon: Icons.phone,
      children: [
        AppTextField(
          label: 'Phone Number',
          controller: _phoneController,
        ),
      ],
    );
  }

  Widget _emailDisplay() {
    return AppIconLabelText(
      label: 'Email',
      text: controller.user.email,
      hint: 'Add Email.',
      icon: Icons.mail,
    );
  }

  Widget _emailEdit() {
    String _desc = r'Email address can only be changed by the _{color:orange}company account owner_.';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ColumnWithIconPrefix(
          icon: Icons.mail,
          children: [
            AppTextField(
              label: 'Email',
              enabled: false,
              initialValue: controller.user.email,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 46.0, bottom: 30),
          child: SimpleRichText(
            _desc,
            style: TextStyles.titleS,
          ),
        ),
      ],
    );
  }

  Widget _addressDisplay() {
    return AppIconLabelText(
      label: 'Address',
      hint: 'Add Service Address.',
      text: controller.user.addressModel?.fullAddress ?? '',
      icon: Icons.location_pin,
    );
  }

  Widget _addressEdit() {
    return GetBuilder<AuthController>(builder: (_) {
      return Stack(
        children: [
          ColumnWithIconPrefix(
            icon: Icons.location_pin,
            children: [
              AppTextField(
                label: 'Street Address',
                controller: _streetController,
                onChanged: (val) {
                  _baseController.searchAddress(val, _selectCountry.value.countryCode);
                },
              ),
              AppTextField(
                label: 'Apartment, unit, suite, or floor #',
                controller: _aptController,
              ),
              AppTextField(
                label: 'City',
                controller: _cityController,
              ),
              FlexRow(
                children: [
                  AppTextField(
                    label: 'State',
                    controller: _stateController,
                  ),
                  AppTextField(
                    label: 'Zip',
                    controller: _zipController,
                  ),
                ],
              ),
              _country()
            ],
          ),
          AddressList(left: 35, right: 0, top: 60,onSelectedSearchedModel: (val) {
            _streetController.text = val.street ?? '';
            _cityController.text = val.city ?? '';
            controller.update();
          }),
        ],
      );
    });
  }

  _country() => InkWell(
    onTap: () => countryPicker(Get.context!, (country) {
      _selectCountry.value = country;
      _countryController.text = country.name;
      controller.update();
    }),
    child: AppTextField(
      label: 'Country / Region',
      enabled: false,
      controller: _countryController,
    ),
  );

  _showAlertDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0)), //this right here
      child: Container(
        width: 360.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const AppHeadingIcon(
              label: "Change Password",
              icon: MdiIcons.lock,
              colorIcon: AppColors.primary_1,
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Old Password',
              mb: 24,
              controller: _oldPasswordController,
              key: const ValueKey('currentPassword'),
            ),
            AppTextField(
                label: 'New Password',
                mb: 24,
                controller: _newPasswordController),
            AppTextField(
              label: 'Confirm New Password',
              mb: 24,
              controller: _confirmPasswordController,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: 'Cancel',
                    primary: false,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(width: 16),
                  AppButtonGradient(
                    label: 'Update Password',
                    onPressed: () {
                      controller.changePassword(
                          oldPassword: _oldPasswordController.text,
                          newPassword: _newPasswordController.text,
                          confirmPassword: _confirmPasswordController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return errorDialog;
      },
    );
  }
}

class AppIconLabelText extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final String text;
  final Color colorLabel;
  final Color colorText;
  final Color colorIcon;
  final Widget? child;
  const AppIconLabelText({
    required this.label,
    required this.text,
    required this.hint,
    this.child,
    this.icon = Icons.chevron_right,
    this.colorIcon = AppColors.secondary_70,
    this.colorLabel = AppColors.secondary_30,
    this.colorText = AppColors.secondary_20,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnWithIconPrefix(
      icon: icon,
      alignment: const Alignment(-1, -1),
      children: [
        Text(
          label,
          style: AppStyles.headerRegular.copyWith(
            fontSize: 16,
            color: colorLabel,
          ),
        ),
        const SizedBox(height: 8),
        if (text.isNotEmpty)
          Text(text,
              style: AppStyles.labelRegular.copyWith(
                color: colorText,
              )),
        if (text.isEmpty)
          Text(
            hint,
            style: AppStyles.labelRegular.copyWith(
              color: AppColors.secondary_60,
              fontSize: 14,
            ),
          ),
        const SizedBox(height: 24)
      ],
    );
  }
}

class AppHeadingIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color colorIcon;
  final Color colorText;
  final Widget? trailing;

  const AppHeadingIcon({
    required this.label,
    this.icon = MdiIcons.chevronRightBox,
    this.colorIcon = AppColors.secondary_60,
    this.colorText = AppColors.secondary_30,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.translate(
          offset: const Offset(-3, 0),
          child: Icon(icon, color: colorIcon),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(label,
            style: AppStyles.headerRegular
                .copyWith(color: colorText, fontSize: 24))
      ],
    );
  }
}

class ColumnWithIconPrefix extends StatelessWidget {
  final List<Widget> children;
  final IconData icon;
  final AlignmentGeometry alignment;

  const ColumnWithIconPrefix(
      {this.children = const <Widget>[],
      this.icon = Icons.chevron_right,
      this.alignment = const Alignment(-1, 0),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 59,
          alignment: alignment,
          child: Icon(icon, size: 18, color: AppColors.secondary_70),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        )
      ],
    );
  }
}
