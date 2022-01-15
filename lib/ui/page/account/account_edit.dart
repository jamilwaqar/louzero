import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/models/user_models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class AccountEdit extends GetWidget<CompanyController> {
  final UserModel userModel;
  AccountEdit({required this.userModel, Key? key}) : super(key: key);
  final editContact = false.obs;
  toggleEdit() => editContact.toggle();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      children: [
        AppHeaderIcon(
          AuthManager.userModel!.fullName,
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
                  AppAvatar(
                    url: userModel.avatar,
                    text: userModel.initials,
                    size: 136,
                    backgroundColor: AppColors.secondary_50,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [_editContact()],
              ),
            )
          ],
        ),
        const AppDivider(
          mt: 32,
        ),
        Obx(() {
          return RowSplit(
            left: editContact.value
                ? Row(
                    children: [
                      Buttons.submit('Update Account'),
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
                if (editContact.value)
                  Container(
                      color: Colors.white.withAlpha(200),
                      height: 41,
                      width: 200)
              ],
            ),
          );
        })
      ],
    );
  }

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
        children: editContact.value ? edit : display,
      );
    });
  }

  Widget _nameEdit() {
    return ColumnWithIconPrefix(
      icon: MdiIcons.accountCircle,
      children: [
        AppTextField(
          label: 'Name',
          initialValue: userModel.fullName,
        ),
      ],
    );
  }

  Widget _phoneDisplay() {
    return AppIconLabelText(
        label: 'phone',
        text: userModel.phone,
        hint: 'Add Phone Number.',
        icon: Icons.phone);
  }

  Widget _phoneEdit() {
    return ColumnWithIconPrefix(
      icon: Icons.phone,
      children: [
        AppTextField(
          label: 'Phone Number',
          initialValue: userModel.phone,
        ),
      ],
    );
  }

  Widget _emailDisplay() {
    return AppIconLabelText(
      label: 'Email',
      text: userModel.email,
      hint: 'Add Email.',
      icon: Icons.mail,
    );
  }

  Widget _emailEdit() {
    return ColumnWithIconPrefix(
      icon: Icons.mail,
      children: [
        AppTextField(
          label: 'Email',
          initialValue: userModel.email,
        ),
      ],
    );
  }

  Widget _addressDisplay() {
    return AppIconLabelText(
      label: 'Address',
      hint: 'Add Service Address.',
      text: userModel.serviceAddress,
      icon: Icons.location_pin,
    );
  }

  Widget _addressEdit() {
    return ColumnWithIconPrefix(
      icon: Icons.location_pin,
      children: [
        AppTextField(
          label: 'Street Address',
          initialValue: '123 Alphabet Street',
        ),
        AppTextField(
          label: 'Apartment, unit, suite, or floor #',
        ),
        AppTextField(
          label: 'City',
          initialValue: 'San Francisco',
        ),
        FlexRow(
          children: [
            AppTextField(
              label: 'State',
              initialValue: 'California',
            ),
            AppTextField(
              label: 'Zip',
              initialValue: '97209',
            ),
          ],
        ),
        AppTextField(
          label: 'Country / Region',
          initialValue: 'United States',
        )
      ],
    );
  }

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
            const AppTextField(
              label: 'Old Password',
              mb: 24,
              key: ValueKey('currentPassword'),
            ),
            const AppTextField(label: 'New Password', mb: 24),
            const AppTextField(label: 'Confirm New Password', mb: 24),
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
                      Get.back();
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
      alignment: Alignment(-1, -1),
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
        SizedBox(height: 24)
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
