import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

class JobsHome extends StatefulWidget {
  const JobsHome(this.jobModel, {Key? key}) : super(key: key);
  final JobModel jobModel;
  @override
  State<JobsHome> createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {

  final _baseController = Get.find<BaseController>();
  final _lineItemController = Get.put(LineItemController());
  final controller = Get.find<JobController>();
  late final jobModel = widget.jobModel;
  bool addLineVisible = false;
  int inventoryIndex = 0;
  bool miscLineItem = false;

  @override
  void initState() {
    _lineItemController.lineItems.value = [
      ...widget.jobModel.billingLineModels
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: GetBuilder<LineItemController>(
        builder: (controller) {
          return _body();
        },
      ),
      subheader: jobModel.jobType,
      footerEnd: [
        AppPopMenu(
          button: [
            AppButtons.appBar(
              label: "Job Status: ${jobModel.status}",
              isMenu: true,
            )
          ],
          items: const [
            PopMenuItem(label: 'Scheduled', icon: MdiIcons.calendarBlank),
            PopMenuItem(label: 'In Progress', icon: MdiIcons.progressClock)
          ],
        )
      ],
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
    CustomerModel customerModel = _baseController.customerModelById(widget.jobModel.customerId!)!;
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
        height: 1200,
        radius: 24,
        children: [
          _tabDetails(),
          _tabSchedule(),
          _tabBilling(),
        ],
        length: 3,
        tabNames: const ['Job Details', 'Schedule', 'Billing']);
  }

  Widget _tabDetails() {
    JobModel jobModel = widget.jobModel;
    DateTime updatedAt = jobModel.updatedAt != null ? jobModel.updatedAt! : jobModel.createdAt;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Job Description', style: AppStyles.headerSmallCaps),
                    const SizedBox(height: 8),
                    Text(widget.jobModel.description, style: AppStyles.labelRegular),
                  ],
                ),
              ),
              const SizedBox(width: 90),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextKeyVal(
                    "Job Id:",
                    "#${widget.jobModel.jobId}",
                    keyStyle: AppStyles.headerSmallCaps,
                    valStyle:
                    AppStyles.bodyLarge.copyWith(color: AppColors.accent_1),
                  ),
                  const SizedBox(height: 4),
                  TextKeyVal(
                    "Status:",
                    widget.jobModel.status,
                    keyStyle: AppStyles.headerSmallCaps,
                    valStyle:
                    AppStyles.bodyLarge.copyWith(color: AppColors.accent_1),
                  ),
                  const SizedBox(height: 8),
                  const Text('Last Updated', style: AppStyles.labelRegular),
                  const SizedBox(height: 8),
                  Text(updatedAt.simpleDate, style: AppStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Text('by ${AuthManager.userModel!.fullName}', style: AppStyles.labelRegular),
                  const SizedBox(height: 16),
                  AppButton(label: 'View Job History', colorBg: AppColors.secondary_99, colorText: AppColors.secondary_20, onPressed: () {}),

                ],
              ),

            ],
          ),
          const AppDivider(color: AppColors.secondary_95,),
          Row(
            children: [
              _categoryItem('Pictures', 'Keep track of location photos, job photos, and more.', 'icon-camera', 3),
              const SizedBox(width: 24),
              _categoryItem('Checklists', 'Check off items that need to be completed for this job.', 'icon-checklists', 3),
            ],
          )
        ],
      ),
    );
  }

  Widget _categoryItem(String title, String description, String icon, int count) {
    return Expanded(
      child: InkWell(
        onTap: () {

        },
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
                              border: Border.all(color: AppColors.primary_80)
                          ),
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
                      style: AppStyles.labelRegular.copyWith(color: AppColors.dark_3, fontSize: 14),
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
    return AppTabPanel(
      children: [
        const Text('Billing Line Items', style: AppStyles.headerRegular),
        if (_lineItemController.lineItems.isEmpty && !addLineVisible)
          const AppPlaceholder(
            title: 'No Line Items',
            subtitle: "Add new line to get started.",
          ),
        AppBillingLines(
          data: _lineItemController.lineItems,
          onDelete: (id) async {
            dynamic response = await _lineItemController.deleteLineItemById(id, widget.jobModel.objectId!);
            if (response is String) {
              WarningMessageDialog.showDialog(context, response);
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
            AppAddNote(initialText: jobModel.note ?? '', onChange: (value) {
              jobModel.note = value;
              controller.save(jobModel);
            }),
            const SizedBox(width: 1),
            AppBillingTotal(
              subtotal: _lineItemController.subTotal,
              tax: 7.32,
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabSchedule() {
    return const AppTabPanel(children: [
      Text('Job Schedule', style: AppStyles.headerRegular),
    ]);
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
            setState(() {
              miscLineItem = false;
              addLineVisible = true;
              inventoryIndex = 0;
            });
          },
        ),
        PopMenuItem(
            label: 'Misc. Billing Line',
            icon: MdiIcons.currencyUsd,
            onTap: () {
              setState(() {
                miscLineItem = true;
                addLineVisible = true;
              });
            }),
      ],
    );
  }

  Widget _addNewLine() {
    return Visibility(
      visible: addLineVisible,
      child: JobAddNewLine(
        jobId: widget.jobModel.objectId!,
        selectedIndex: inventoryIndex,
        isTextInput: miscLineItem,
        onCreate: () {
          setState(() {
            addLineVisible = false;
          });
        },
        onCancel: () {
          setState(() {
            addLineVisible = false;
          });
        },
      ),
    );
  }
}
