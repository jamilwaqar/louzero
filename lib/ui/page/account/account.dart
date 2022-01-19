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
import 'package:simple_rich_text/simple_rich_text.dart';

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
        Opacity(
            opacity: model.status == CompanyStatus.active ? 1 : 0,
            child: Buttons.outline('SWITCH TO',
                icon: Icons.compare_arrows_outlined, onPressed: () {})),
        const SizedBox(width: 18),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: model.status.color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppTextBody(
            model.status.label,
            color: model.status.labelColor,
          ),
        ),
        PopupMenuButton(
            padding: EdgeInsets.zero,
            offset: const Offset(0, 40),
            onSelected: (value) {
              controller.company = model;
              if (value == 0) {
                Get.to(() => CompanyPage(), arguments: model);
              } else if (value == 1) {
                Get.to(() => const AddCompanyPage());
              } else if (value == 2) {
                _showReactivateDialog();
              }
            },
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.medium_2, width: 0)),
            child: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              if(model.status == CompanyStatus.active)
                  PopupMenuItem(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: AppColors.orange,
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
              if(model.status == CompanyStatus.active)
                  PopupMenuItem(
                    child: SizedBox(
                      width: 200,
                      height: 60,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: AppColors.orange,
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
              if(model.status == CompanyStatus.cancel)
              PopupMenuItem(
                child: SizedBox(
                  width: 200,
                  height: 60,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: AppColors.orange,
                      ),
                      SizedBox(width: 10),
                      Text("Reactivate Company",
                          style: TextStyle(
                            color: AppColors.icon,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
                value: 2,
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

  // TODO: Don't remove this: Reactivate Dialog
  _showReactivateDialog() {
    String _desc = 'To reactivate *Old Cancelled Company*, please email us *{color:orange}help@evosus.com* and we’ll get back to you as soon as possible';
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)), //this right here
      child: Container(
        width: 360.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Reactivate Company', style: AppStyles.headerAppBar.copyWith(color: AppColors.secondary_30)),
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
                  AppButton(label: 'Cancel', primary: false, onPressed: () {
                    Get.back();
                  },),
                  const SizedBox(width: 16),
                  AppButton(label: 'Got it', colorBg: AppColors.orange ,onPressed: () {
                    Get.back();
                  },),
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
