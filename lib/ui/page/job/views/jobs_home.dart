import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'package:louzero/common/common.dart';

import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/line_item.dart';

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);
  final _controller = Get.put(LineItemController());

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

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      child: Column(
        children: [
          _locationCard(),
          _tabs(),
        ],
      ),
    );
  }

  Widget _locationCard() {
    return AppCardExpandable(
      title: const AppHeaderIcon('Archwood House'),
      subtitle: RowSplit(
        space: 'center',
        left: TextIcon(
          _controller.fullAddress,
          MdiIcons.mapMarker,
        ),
        right: const TextKeyVal(
          "Acct. Balance:",
          "\$978.00",
        ),
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 316,
                decoration: BoxDecoration(
                    color: AppColors.secondary_95,
                    borderRadius: Common.border_24.copyWith(
                      topRight: const Radius.circular(0),
                      bottomRight: const Radius.circular(0),
                    )),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Container(
                height: 316,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppCustomerInfo(
                              address: _controller.billingAddress,
                              contact: _controller.contact),
                        ],
                      ),
                      Column(
                        children: [
                          const AppDivider(mt: 0, mb: 16),
                          Row(
                            children: const [
                              AppButtons.iconFlat(
                                'Parent Account',
                                icon: MdiIcons.arrowTopRight,
                                colorIcon: AppColors.secondary_60,
                              ),
                              Spacer(),
                              AppButtons.iconOutline(
                                'Site Profile',
                                icon: MdiIcons.homeCity,
                              ),
                              SizedBox(width: 8),
                              AppButtons.iconOutline(
                                'Site Profile',
                                icon: MdiIcons.homeCity,
                              ),
                            ],
                          )
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ],
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

  Widget _tabBilling() {
    return AppTabPanel(
      children: [
        const Text('Billing Line Items', style: AppStyles.headerRegular),
        AppBillingLines(data: _controller.lineItems),
        JobAddNewLine(
          onCreate: (LineItem item) {
            _controller.addLineItem(item);
          },
        ),
        const AppPopMenu(
          button: [
            AppButtons.iconOutline(
              'Add New Line',
              isMenu: true,
            )
          ],
          items: [
            PopMenuItem(label: 'Inventory Line', icon: MdiIcons.clipboardText),
            PopMenuItem(
                label: 'Misc. Billing Line', icon: MdiIcons.currencyUsd),
          ],
        ),
        const AppDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            AppButtons.iconFlat('Add Note', icon: MdiIcons.note),
            Expanded(
              child: AppBillingTotal(
                subtotal: 1246.57,
                tax: 7.32,
              ),
            )
          ],
        ),
      ],
    );
  }
  // End Class
}

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool trail;
  final double size;
  const TextIcon(
    this.text,
    this.icon, {
    this.trail = false,
    this.size = 14,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!trail)
          Icon(
            icon,
            color: AppColors.primary_60,
            size: size,
          ),
        Text(text, style: AppStyles.labelRegular.copyWith(fontSize: size)),
        if (trail)
          Icon(
            icon,
            color: AppColors.primary_60,
            size: size,
          ),
      ],
    );
  }
}

class AppHeaderIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextStyle style;
  final double mt;
  final double mb;

  const AppHeaderIcon(
    this.title, {
    this.icon = MdiIcons.arrowTopRight,
    this.style = AppStyles.headerRegular,
    this.mb = 8,
    this.mt = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: mb, top: mt),
      child: Row(
        children: [
          Text(
            title,
            style: style,
          ),
          AppIconButton(
            pl: 8,
            icon: icon,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
