import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart' hide ItemTags;
import 'package:get/get.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/company/add_company.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';
import 'item_tags.dart';

class CompanyPage extends GetWidget<CompanyController> {
  CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBaseScaffold(
          child: Column(
            children: [
              SizedBox(height: 32),
              _info(),
            ],
          ),
          subheader: controller.company.name,
        ));
  }

  Widget _info() {
    CompanyModel model = controller.company;
    return AppCard(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(model.name,
                                style: TextStyles.headLineS
                                    .copyWith(color: AppColors.dark_2)),
                            const SizedBox(width: 8),
                            TopLeftButton(
                                onPressed: () {
                                  Get.to(() => const AddCompanyPage());
                                },
                                iconData: Icons.edit),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 60,
                                  child: AppTextBody(
                                    Get.find<BaseController>()
                                                .activeCompany!
                                                .objectId ==
                                            model.objectId
                                        ? 'Active'
                                        : '',
                                    color: AppColors.accent_1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(
            indent: 24,
            endIndent: 24,
            thickness: 2,
            color: AppColors.light_1,
            height: 0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _logo(),
                  const SizedBox(height: 6),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 200,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.light_3)),
                        child: Text(
                          'Update Logo',
                          style: TextStyles.labelM
                              .copyWith(color: AppColors.dark_3),
                        ),
                      ),
                      onPressed: () {
                        controller.uploadAvatar();
                      })
                ],
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        appIcon(Icons.home_work, color: AppColors.dark_1),
                        const SizedBox(width: 8),
                        const Text('Contact Information',
                            style: TextStyles.labelL),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.address!.fullAddress,
                            style: TextStyles.bodyL
                                .copyWith(color: AppColors.dark_3),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.email,
                            style: TextStyles.bodyL.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColors.dark_3),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.phone,
                            style: TextStyles.bodyL
                                .copyWith(color: AppColors.dark_3),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     appIcon(Icons.person, color: AppColors.dark_1),
                    //     const SizedBox(width: 8),
                    //     const Text('Account Owner', style: TextStyles.labelL),
                    //   ],
                    // ),
                    // const SizedBox(height: 24),
                    Row(
                      children: [
                        appIcon(Icons.home_work, color: AppColors.dark_1),
                        const SizedBox(width: 8),
                        const Text('Industries', style: TextStyles.labelL),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 30),
                      child: _industriesTag(model.industries),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        appIcon(Icons.home_work, color: AppColors.dark_1),
                        const SizedBox(width: 8),
                        const Text('Job Settings', style: TextStyles.labelL),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 30),
                      child: Text('Job Scheduling starts at: 8.00am',
                          style: TextStyles.labelL
                              .copyWith(color: AppColors.dark_3)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
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
            textStyle: TextStyles.titleS,
            activeColor: AppColors.dark_1,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6));
      },
    );
  }
}
