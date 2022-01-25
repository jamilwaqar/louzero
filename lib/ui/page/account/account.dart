import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/account/account_edit.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/page/company/company.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyAccountPage extends GetWidget<CompanyController> {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: Column(
        children: [
          const SizedBox(height: 32),
          AccountEdit(),
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
        Buttons.outline("Add Company", icon: Icons.add_circle, onPressed: () {
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
    String status = model.status.label.toLowerCase();
    Color _colorIcon =
        status == 'cancelled' ? AppColors.secondary_90 : AppColors.secondary_50;
    Color _colorText =
        status == 'cancelled' ? AppColors.secondary_70 : AppColors.secondary_20;

    return BorderBox(
      height: 60,
      widthBorder: 4,
      colorBorder: getColor(index),
      colorBg: getRowColor(index),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            alignment: Alignment(-1, 0),
            child: _companyAvatar(model, colorIcon: _colorIcon),
          ),
          Expanded(
            child: Row(
              children: [
                Text(model.name,
                    style: AppStyles.labelBold.copyWith(color: _colorText)),
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
          ),
          if (index != controller.selectedCompany && status != 'cancelled')
            Buttons.outlineSM('Switch to Company',
                icon: MdiIcons.swapHorizontal, onPressed: () {
              controller.selectedCompany = index;
            }),
          JobStatusLabel(
            label: model.status.label,
          ),
          AppPopMenu(
            onSelected: (val) {
              controller.company = model;
              if (val == 'View Company') {
                Get.to(() => CompanyPage(), arguments: model);
              }
              if (val == 'Edit Company') {
                Get.to(() => const AddCompanyPage());
              }
              if (val == 'Reactivate Company') {
                _showReactivateDialog();
              }
            },
            button: const [
              Icon(Icons.more_vert, color: AppColors.secondary_30)
            ],
            items: [
              if (model.status == CompanyStatus.active)
                const PopMenuItem(
                  label: 'View Company',
                  icon: MdiIcons.arrowTopRight,
                ),
              if (model.status == CompanyStatus.active)
                const PopMenuItem(
                  label: 'Edit Company',
                  icon: Icons.edit,
                ),
              if (model.status == CompanyStatus.cancel)
                const PopMenuItem(
                  label: 'Reactivate Company',
                  icon: Icons.edit,
                ),
            ],
          ),
          const SizedBox(width: 16)
        ],
      ),
    );
  }

  Widget _companyAvatar(
    CompanyModel model, {
    IconData icon = Icons.home_work,
    Color colorIcon = AppColors.secondary_50,
  }) {
    return model.avatar == null
        ? appIcon(icon, color: colorIcon)
        : _cachedNetworkImage(model.avatar!.toString());
  }

  Widget _cachedNetworkImage(String url, {double size = 32}) =>
      CachedNetworkImage(
          width: size,
          height: size * 0.75,
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
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
    String _start = 'To reactivate *Old Cancelled Company*, please email us ';
    String _link = 'help@evosus.com ';
    String _end = 'and we’ll get back to you as soon as possible.';
    TextStyle _textStyle = AppStyles.labelRegular.copyWith(height: 1.65);
    TextStyle _linkStyle = AppStyles.labelRegular
        .copyWith(height: 1.65, color: AppColors.primary_50);

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0)), //this right here
      child: Container(
        width: 360.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reactivate Company', style: AppStyles.headlineMedium),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: _start, style: _textStyle),
                  TextSpan(text: _link, style: _linkStyle),
                  TextSpan(text: _end, style: _textStyle)
                ],
                style: AppStyles.labelRegular.copyWith(height: 1.65),
              ),
            ),
            const SizedBox(height: 24),
            RowSplit(
              right: Row(
                children: [
                  Buttons.text('Cancel', onPressed: () {
                    Get.back();
                  }),
                  const SizedBox(width: 16),
                  Buttons.primary('Got It', onPressed: () {
                    Get.back();
                  })
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

class JobStatusLabel extends StatelessWidget {
  final String label;
  const JobStatusLabel({Key? key, required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color _color = AppColors.secondary_90;
    Color _colorText = AppColors.secondary_50;

    switch (label.toLowerCase()) {
      case 'active':
        _color = AppColors.success_lt;
        _colorText = AppColors.secondary_50;
        break;
      case 'cancelled':
        _color = AppColors.error_50;
        _colorText = AppColors.secondary_80;
        break;
      default:
        _color = AppColors.secondary_90;
        _colorText = AppColors.secondary_50;
    }

    return Container(
      width: 140,
      child: Row(
        children: [
          SizedBox(width: 24),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
          ),
          const SizedBox(width: 8),
          Text(label, style: AppStyles.labelRegular.copyWith(color: _colorText))
        ],
      ),
    );
  }
}
