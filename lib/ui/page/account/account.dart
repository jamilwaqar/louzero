import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/account/account_edit.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/page/company/company.dart';
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
      child: Column(
        children: [
          SizedBox(height: 32),
          AccountEdit(userModel: AuthManager.userModel!),
          _companies(),
        ],
      ),
      subheader: 'My Account',
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

  Color getColor(int index) {
    if (index == controller.selectedCompany) {
      return AppColors.primary_1;
    }
    return Colors.transparent;
  }

  Color getRowColor(int index) {
    if (index == controller.selectedCompany) {
      return Colors.white;
    }
    return index.isOdd ? AppColors.oddItemColor : AppColors.evenItemColor;
  }

  Widget _companyItem(int index) {
    CompanyModel model = controller.companies[index];
    return BorderBox(
      height: 60,
      widthBorder: 4,
      colorBorder: getColor(index),
      colorBg: getRowColor(index),
      child: FlexRow(
        flex: const [0, 1, 0, 0, 0, 0, 0],
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: _companyAvatar(model),
          ),
          Row(
            children: [
              Text(model.name, style: AppStyles.labelBold),
              const SizedBox(
                width: 24,
              ),
              if (index == controller.selectedCompany)
                const Icon(
                  Icons.check,
                  color: AppColors.primary_1,
                  size: 20,
                )
            ],
          ),
          if (index != controller.selectedCompany)
            Buttons.outline_sm('Switch to Company',
                icon: MdiIcons.swapHorizontal, onPressed: () {
              controller.selectedCompany = index;
            }),
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, gradient: AppColors.grad_success),
          ),
          Text(model.status.label,
              style: AppStyles.labelRegular
                  .copyWith(color: AppColors.secondary_50)),
          AppPopMenu(
            onSelected: (val) {
              controller.company = model;
              if (val == 'View Company') {
                Get.to(() => CompanyPage(), arguments: model);
              }
              if (val == 'Edit Company') {
                Get.to(() => const AddCompanyPage());
              }
            },
            button: const [
              Icon(Icons.more_vert, color: AppColors.secondary_30)
            ],
            items: const [
              PopMenuItem(
                label: 'View Company',
                icon: MdiIcons.arrowTopRight,
              ),
              PopMenuItem(
                label: 'Edit Company',
                icon: Icons.edit,
              ),
            ],
          ),
          const SizedBox(width: 0)
        ],
      ),
    );
  }

  Widget _companyAvatar(CompanyModel model) {
    return model.avatar == null
        ? appIcon(Icons.home_work, color: AppColors.secondary_50)
        : _cachedNetworkImage(model.avatar!.toString());
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

  // TODO: Don't remove this: Reactivate Dialog
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

class BorderBox extends StatelessWidget {
  final Widget? child;
  final Color? colorBg;
  final Color? colorBorder;
  final double height;
  final double widthBorder;
  const BorderBox({
    Key? key,
    required this.child,
    this.height = 60,
    this.widthBorder = 7,
    this.colorBg = AppColors.secondary_99,
    this.colorBorder = AppColors.secondary_80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
                padding: EdgeInsets.only(left: 14),
                color: colorBg,
                child: child),
          ),
          Container(
            width: widthBorder,
            height: height,
            decoration: BoxDecoration(color: colorBorder),
          )
        ],
      ),
    );
  }
}
