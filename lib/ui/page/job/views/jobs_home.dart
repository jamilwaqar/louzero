import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:louzero/ui/page/job/views/job_schedule.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JobsHome extends GetWidget<JobController> {
  JobsHome({Key? key}) : super(key: key);

  final _baseController = Get.find<BaseController>();
  late final _lineItemController = Get.find<LineItemController>()
    ..lineItems.value = [...controller.jobModel!.billingLineModels];

  final _addLineVisible = false.obs;
  final _inventoryIndex = 0.obs;
  final _miscLineItem = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
      builder: (controller) {
        return AppBaseScaffold(
          hasKeyboard: true,
          child: _body(),
          subheader: controller.jobModel!.jobType,
          footerEnd: [
            AppPopMenu(
              button: [
                Buttons.appBar(
                  'Job Status: ${controller.jobModel!.status}',
                  icon: MdiIcons.calculator,
                )
              ],
              items: const [
                PopMenuItem(label: 'Scheduled', icon: MdiIcons.calendarBlank),
                PopMenuItem(label: 'In Progress', icon: MdiIcons.progressClock)
              ],
            )
          ],
        );
      },
    );
  }

  _editLineItem(String id) {
    var item = _lineItemController.lineItems.firstWhereOrNull((el) {
      return el.objectId == id;
    });
    if (item != null) {
      _lineItemController.editLineId = id;
    }
  }

  _duplicateLineItem(String id) {
    var item = _lineItemController.lineItems.firstWhereOrNull((el) {
      return el.objectId == id;
    });

    if (item != null) {
      _lineItemController.addLineItem(item.clone());
    }
  }

  _reorderLineItems(int a, int b) {
    // print('$a, $b');
  }

  Widget _body() {
    CustomerModel customerModel =
        _baseController.customerModelById(controller.jobModel!.customerId!)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      child: Column(
        children: [
          ContactCard(
            title: customerModel.customerContacts[0].fullName,
            contact: customerModel.customerContacts[0],
            address: customerModel.billingAddress,
            trailing: const TextKeyVal("Acct. Balance:", "\$978.00"),
          ),
          _tabs(),
        ],
      ),
    );
  }

  Widget _tabs() {
    return AppCardTabs(
        radius: 24,
        children: [
          _tabDetails(),
          JobSchedule(),
          _tabBilling(),
        ],
        length: 3,
        tabNames: const ['Job Details', 'Schedule', 'Billing']);
  }

  Widget _tabDetails() {
    DateTime updatedAt = controller.jobModel!.updatedAt != null
        ? controller.jobModel!.updatedAt!
        : controller.jobModel!.createdAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Job Description',
                      style: AppStyles.headerSmallCaps),
                  const SizedBox(height: 8),
                  Text(controller.jobModel!.description,
                      style: AppStyles.labelRegular),
                ],
              ),
            ),
            const SizedBox(width: 90),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextKeyVal(
                  "Job Id:",
                  "#${controller.jobModel!.jobId}",
                  keyStyle: AppStyles.headerSmallCaps,
                  valStyle:
                      AppStyles.bodyLarge.copyWith(color: AppColors.accent_1),
                ),
                const SizedBox(height: 4),
                TextKeyVal(
                  "Status:",
                  controller.jobModel!.status,
                  keyStyle: AppStyles.headerSmallCaps,
                  valStyle:
                      AppStyles.bodyLarge.copyWith(color: AppColors.accent_1),
                ),
                const SizedBox(height: 8),
                const Text('Last Updated', style: AppStyles.labelRegular),
                const SizedBox(height: 8),
                Text(updatedAt.simpleDate, style: AppStyles.bodyMedium),
                const SizedBox(height: 8),
                Text('by ${Get.find<AuthController>().user.fullName}',
                    style: AppStyles.labelRegular),
                const SizedBox(height: 16),
                AppButton(
                    label: 'View Job History',
                    colorBg: AppColors.secondary_99,
                    colorText: AppColors.secondary_20,
                    onPressed: () {}),
              ],
            ),
          ],
        ),
        const AppDivider(
          color: AppColors.secondary_95,
        ),
        Row(
          children: [
            _categoryItem(
                'Pictures',
                'Keep track of location photos, job photos, and more.',
                'icon-camera',
                3),
            const SizedBox(width: 24),
            _categoryItem(
                'Checklists',
                'Check off items that need to be completed for this job.',
                'icon-checklists',
                3),
          ],
        )
      ],
    );
  }

  Widget _categoryItem(
      String title, String description, String icon, int count) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.topLeft,
          height: 132,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.light_2, width: 1),
            color: AppColors.lightest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: AppImage(
                  icon,
                  width: 64,
                  height: 64,
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(title,
                                style: TextStyles.titleL
                                    .copyWith(color: AppColors.dark_3))),
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary_95,
                              border: Border.all(color: AppColors.primary_80)),
                          child: Text('$count',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.dark_3,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: AppStyles.labelRegular
                          .copyWith(color: AppColors.dark_3, fontSize: 14),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBilling() {
    return GetBuilder<LineItemController>(
        builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Billing Line Items',
                    style: AppStyles.headerRegular),
                if (_lineItemController.lineItems.isEmpty &&
                    !_addLineVisible.value)
                  const AppPlaceholder(
                    title: 'No Line Items',
                    subtitle: "Add new line to get started.",
                  ),
                AppBillingLines(
                  data: _lineItemController.lineItems,
                  onDelete: (id) async {
                    dynamic response = await _lineItemController
                        .deleteLineItemById(id, controller.jobModel!.objectId!);
                    if (response is String) {
                      WarningMessageDialog.showDialog(Get.context!, response);
                    }
                  },
                  onDuplicate: (id) {
                    _duplicateLineItem(id);
                  },
                  onEdit: (id) {
                    _editLineItem(id);
                  },
                  onReorder: _reorderLineItems,
                ),
                _addNewLine(),
                _addItemButton(),
                const AppDivider(),
                FlexRow(
                  flex: const [12, 0, 7],
                  children: [
                    AppAddNote(
                        initialText: controller.jobModel!.note ?? '',
                        onChange: (value) {
                          controller.jobModel!.note = value;
                          controller.save(controller.jobModel!);
                        }),
                    const SizedBox(width: 1),
                    AppBillingTotal(
                      subtotal: _lineItemController.subTotal,
                      tax: 7.32,
                    ),
                  ],
                ),
              ],
            ));
  }

  Widget _addItemButton() {
    return AppPopMenu(
      button: const [
        AppButtons.iconOutline(
          'Add New Line',
          isMenu: true,
        )
      ],
      items: [
        PopMenuItem(
          label: 'Inventory Line',
          icon: MdiIcons.clipboardText,
          onTap: () {
            _miscLineItem.value = false;
            _addLineVisible.value = true;
            _inventoryIndex.value = 0;
          },
        ),
        PopMenuItem(
            label: 'Misc. Billing Line',
            icon: MdiIcons.currencyUsd,
            onTap: () {
              _miscLineItem.value = true;
              _addLineVisible.value = true;
            }),
      ],
    );
  }

  Widget _addNewLine() {
    return Obx(() => Visibility(
          visible: _addLineVisible.value,
          child: JobAddNewLine(
            jobId: controller.jobModel!.objectId!,
            selectedIndex: _inventoryIndex.value,
            isTextInput: _miscLineItem.value,
            onCreate: () {
              _addLineVisible.value = false;
            },
            onCancel: () {
              _addLineVisible.value = false;
            },
          ),
        ));
  }
}
