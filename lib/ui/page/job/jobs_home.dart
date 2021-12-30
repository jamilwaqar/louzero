import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'models/line_item.dart';

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);
  final billingController = Get.put(LineItemController());

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
      subtitle: _locationSubtitle(billingController.fullAddress),
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
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    )),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Container(
                height: 316,
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppDivider(mt: 0, mb: 24),
                          _hdr('Primary Contact'),
                          SizedBox(height: 8),
                          _txt(billingController.nameAndRole),
                          _txt(billingController.contact.email,
                              color: Color(0xFF86421A)),
                          _txt(billingController.contact.phone),
                          SizedBox(height: 24),
                          _hdr('Billing Address'),
                          SizedBox(height: 8),
                          _txt(billingController.billingAddress.street),
                          _txt(billingController.cityStateZip),
                          _txt(billingController.billingAddress.country),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            AppDivider(mt: 0, mb: 16),
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
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _txt(String text, {color = AppColors.secondary_20}) {
    return Text(text, style: AppStyles.bodyLarge.copyWith(color: color));
  }

  Widget _hdr(String text, {color = AppColors.secondary_20}) {
    return Text(text.toUpperCase(),
        style: AppStyles.headerSmallCaps.copyWith(color: color));
  }

  Widget _locationSubtitle(String address, {balance = '\$768.00'}) {
    return Split(
      TextIcon(
        address,
        MdiIcons.mapMarker,
      ),
      TextKeyVal(
        "Acct. Balance:",
        balance,
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
        AppBillingLines(data: billingController.lineItems),
        JobAddNewLine(
          onCreate: (LineItem item) {
            billingController.addLineItem(item);
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

class Split extends StatelessWidget {
  final Widget? first;
  final Widget? last;
  const Split(this.first, this.last, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (first != null)
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [first!],
          ),
        if (last != null)
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [last!],
          )
      ],
    );
  }
}

class AppSplitRow extends StatelessWidget {
  final List<Widget> start;
  final List<Widget> end;
  final double pt;
  final double pb;
  final double pr;
  final double pl;

  const AppSplitRow({
    Key? key,
    this.start = const [],
    this.end = const [],
    this.pt = 0,
    this.pb = 0,
    this.pr = 0,
    this.pl = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: pt, left: pl, right: pr, bottom: pb),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: start,
            ),
          ),
          Row(
            children: end,
          )
        ],
      ),
    );
  }
}

class TextKeyVal extends StatelessWidget {
  final String _key;
  final String val;
  final double size;
  final double gap;
  final TextStyle? keyStyle;
  final TextStyle? valStyle;

  const TextKeyVal(
    this._key,
    this.val, {
    this.size = 14,
    this.gap = 8,
    this.keyStyle,
    this.valStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle s1 = keyStyle ?? AppStyles.labelRegular.copyWith(fontSize: size);
    TextStyle s2 = keyStyle ?? AppStyles.labelBold.copyWith(fontSize: size);
    return Row(
      children: [
        Text(_key, style: s1),
        SizedBox(width: gap),
        Text(
          val,
          style: s2,
        )
      ],
    );
  }
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

  const AppHeaderIcon(
    this.title, {
    Key? key,
    this.icon = MdiIcons.arrowTopRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.headerRegular,
        ),
        AppIconButton(
          pl: 8,
          icon: icon,
          onTap: () {},
        ),
      ],
    );
  }
}
