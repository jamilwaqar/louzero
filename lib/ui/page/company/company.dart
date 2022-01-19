import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart' hide ItemTags;
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/layout.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'item_tags.dart';

class CompanyPage extends GetWidget<CompanyController> {
  CompanyPage({Key? key}) : super(key: key);

  void _onUpload() {
    controller.uploadAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBaseScaffold(
          child: Column(
            children: [
              const SizedBox(height: 32),
              _info(),
            ],
          ),
          subheader: 'My Company',
        ));
  }

  Widget _info() {
    CompanyModel model = controller.company;
    return AppCard(
      children: [
        AppHeaderIcon(
          model.name,
          icon: Icons.edit,
          iconStart: MdiIcons.accountCircle,
          onTap: () {
            Get.to(() => const AddCompanyPage());
          },
        ),
        const AppDivider(
          mt: 8,
          mb: 40,
        ),
        FlexRow(
          flex: [2, 3],
          children: [
            // LEFT COLUMN
            Column(
              children: [
                GestureDetector(
                  onTap: _onUpload,
                  child: _logo(),
                )
              ],
            ),
            // RIGHT COLUMN
            Column(
              children: [
                Ui.headingSM('Contact Information and mustard',
                    icon: Icons.favorite),
                Ui.block(
                  children: [
                    Ui.text(model.address!.fullAddress),
                    Ui.text(model.email, color: AppColors.primary_30),
                    Ui.text(model.phone),
                  ],
                ),
                Ui.headingSM('Account Owner', icon: Icons.person),
                Ui.block(
                  children: [
                    Ui.text("NAME NEEDED HERE"),
                    Ui.text(model.email),
                  ],
                ),
                Ui.headingSM('Industries', icon: MdiIcons.domain),
                SizedBox(height: 8),
                Ui.block(
                  children: [_industriesTag(model.industries)],
                ),
                Ui.headingSM('Job Settings', icon: MdiIcons.briefcase),
                Ui.block(children: [
                  Ui.text('Job Scheduling starts at: 8.00am'),
                ])
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _logo() {
    Uri? uri = controller.company.avatar;
    if (uri == null) {
      return const AppImage(
        'icon-company-logo',
        width: 198,
        height: 136,
      );
    }
    return SizedBox(
      width: 198,
      height: 136,
      child: CachedNetworkImage(
          imageUrl: uri.toString(),
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
                  strokeWidth: 2,
                ),
              ),
          errorWidget: (context, url, error) {
            return const AppImage(
              'icon-company-logo',
              width: 198,
              height: 136,
            );
          }),
    );
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  Widget _industriesTag(List<String> items) {
    return Tags(
      key: _tagStateKey,
      itemCount: items.length,
      alignment: WrapAlignment.start,
      spacing: 4,
      runSpacing: 8,
      textField: null,
      itemBuilder: (int index) {
        String item = items[index];
        return ItemTags(
          key: Key('$item-$index'),
          customData: item,
          index: index,
          title: items[index],
          pressEnabled: false,
          textStyle: AppStyles.labelBold,
          textColor: AppColors.secondary_40,
          textActiveColor: AppColors.secondary_40,
          activeColor: AppColors.secondary_99,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: Border.all(color: AppColors.secondary_40),
          elevation: 0,
        );
      },
    );
  }
}
