import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/line_item.dart';
import 'package:collection/collection.dart';

class JobsHome extends StatefulWidget {
  const JobsHome({Key? key}) : super(key: key);

  @override
  State<JobsHome> createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {
  final _controller = Get.put(LineItemController());
  bool addLineVisible = false;
  int inventoryIndex = 0;
  bool miscLineItem = false;
  LineItem? initialData;

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: GetBuilder<LineItemController>(
        builder: (controller) {
          return _body();
        },
      ),
      subheader: 'Repair',
      footerEnd: const [
        AppPopMenu(
          button: [
            AppButtons.appBar(
              label: "Job Status",
              isMenu: true,
            )
          ],
          items: [
            PopMenuItem(label: 'Scheduled', icon: MdiIcons.calendarBlank),
            PopMenuItem(label: 'In Progress', icon: MdiIcons.progressClock)
          ],
        )
      ],
    );
  }

  _editLineItem(String id) {
    var item = _controller.lineItems.firstWhereOrNull((el) {
      return el.id == id;
    });

    if (item != null) {
      inspect(item);
    }
  }

  _duplicateLineItem(String id) {
    var item = _controller.lineItems.firstWhereOrNull((el) {
      return el.id == id;
    });

    if (item != null) {
      inspect(item);
    }
  }

  _reorderLineItems(int a, int b) {
    // print('$a, $b');
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      child: Column(
        children: [
          ContactCard(
            title: 'Archwood House',
            contact: _controller.contact,
            address: _controller.address,
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
          _tabBilling(),
          _tabDetails(),
          _tabSchedule(),
        ],
        length: 3,
        tabNames: const ['Job Details', 'Schedule', 'Billing']);
  }

  Widget _tabBilling() {
    return AppTabPanel(
      children: [
        const Text('Billing Line Items', style: AppStyles.headerRegular),
        if (_controller.lineItems.isEmpty && !addLineVisible)
          const AppPlaceholder(
            title: 'No Line Items',
            subtitle: "Add new line to get started.",
          ),
        AppBillingLines(
          data: _controller.lineItems,
          onDelete: (id) {
            _controller.deleteLineItemById(id);
          },
          onDuplicate: _duplicateLineItem,
          onEdit: _editLineItem,
          onReorder: _reorderLineItems,
        ),
        Visibility(
          visible: addLineVisible,
          child: JobAddNewLine(
            initialData: initialData,
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
        ),
        _addItemButton(),
        const AppDivider(),
        FlexRow(
          flex: const [12, 0, 7],
          children: [
            const AppAddNote(),
            const SizedBox(width: 1),
            AppBillingTotal(
              subtotal: _controller.subTotal,
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

  Widget _tabDetails() {
    return const AppTabPanel(children: [
      Text('Job Details', style: AppStyles.headerRegular),
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
}
