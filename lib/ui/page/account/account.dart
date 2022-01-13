import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/account/edit_account.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/page/company/company.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

class MyAccountPage extends GetWidget<CompanyController> {
  final UserModel userModel;
  MyAccountPage(this.userModel, {Key? key}) : super(key: key);
  var editContact = false.obs;
  toggleEdit() => editContact.toggle();

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: _body(),
      subheader: 'My Account',
    );
  }

  Widget _body() {
    return Column(
      children: [
        SizedBox(height: 32),
        _accountInfo(),
        _companies(),
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
        children: editContact.value ? display : edit,
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

  Widget _companies() {
    return AppCard(
      radius: 16,
      children: [
        GetBuilder<CompanyController>(
            builder: (_) => ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.companies.length,
                itemBuilder: (context, index) => _companyItem(index))),
        const SizedBox(height: 32),
        AppAddButton("Add Company", onPressed: () {
          Get.to(() => const AddCompanyPage());
        }),
      ],
    );
  }

  Widget _companyItem(int index) {
    CompanyModel model = controller.companies[index];
    return Container(
      color: index.isOdd ? AppColors.oddItemColor : AppColors.evenItemColor,
      height: 65,
      child: Row(children: [
        const SizedBox(width: 24),
        _companyAvatar(model),
        const SizedBox(width: 24),
        Expanded(
          child: AppTextBody(
            model.name,
            color: AppColors.dark_2,
            bold: true,
          ),
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.medium_2),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AppTextBody(
            model.status.label,
          ),
        ),
        AppButton(
          margin: const EdgeInsets.only(right: 8),
          label: 'SWITCH TO',
          colorBg: AppColors.dark_1,
          colorText: AppColors.darkest,
          primary: false,
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        PopupMenuButton(
            padding: EdgeInsets.zero,
            offset: const Offset(0, 40),
            onSelected: (value) {
              controller.company = model;
              if (value == 0) {
                Get.to(() => CompanyPage(), arguments: model);
              } else if (value == 1) {
                Get.to(() => const AddCompanyPage());
              }
            },
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.medium_2, width: 0)),
            child: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: AppColors.icon,
                          ),
                          SizedBox(width: 10),
                          Text("View Company",
                              style: TextStyle(
                                color: AppColors.icon,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: AppColors.icon,
                          ),
                          SizedBox(width: 10),
                          Text("Edit Company",
                              style: TextStyle(
                                color: AppColors.icon,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ],
                      ),
                    ),
                    value: 1,
                  ),
                ]),
        const SizedBox(width: 24),
      ]),
    );
  }

  Widget _companyAvatar(CompanyModel model) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.dark_2),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightest),
      child: model.avatar == null
          ? appIcon(Icons.home_work)
          : _cachedNetworkImage(model.avatar!.toString()),
    );
  }

  Widget _cachedNetworkImage(String url) => CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
      placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
      errorWidget: (context, url, error) {
        return Container();
      });

  Widget _accountInfo() {
    return AppCard(
      children: [
        AppHeaderIcon(
          'Alan Whitaker',
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
        RowSplit(
          right: AppButtons.iconOutline(
            'Change Password',
            icon: MdiIcons.lock,
            onPressed: () {
              _showAlertDialog();
            },
          ),
        )
      ],
    );
  }

  Widget _profile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAvatar(
            url: userModel.avatar,
            text: userModel.initials,
            size: 96,
            backgroundColor: AppColors.medium_2),
        const SizedBox(height: 8),
        Text(userModel.fullName,
            style: TextStyles.titleM.copyWith(fontWeight: FontWeight.bold)),
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

  _showReactivateDialog() {
    String _desc =
        'To reactivate *Old Cancelled Company*, please email us *help@evosus.com* and we’ll get back to you as soon as possible';
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0)), //this right here
      child: Container(
        width: 360.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const AppTextHeader(
              'Reactivate Company',
              size: 24,
              alignLeft: true,
            ),
            const SizedBox(height: 24),
            SimpleRichText(
              _desc,
              style: TextStyles.titleS,
            ),
            const SizedBox(height: 24),
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
                  AppButton(
                    label: 'Email',
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // show the dialog
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
