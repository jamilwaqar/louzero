import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);

  List<LineItem> rowData = <LineItem>[
    const LineItem(
      description: 'Clean Pool',
      count: 1,
      price: 50.00,
      subtotal: 50.00,
    ),
    const LineItem(
      description: 'Replace Valve Seals',
      count: 4,
      price: 5.00,
      subtotal: 20.00,
    ),
    const LineItem(
      description: 'Calcium Hardness Increaser',
      count: 1,
      price: 16.48,
      subtotal: 16.48,
    ),
    const LineItem(
      description: 'Item from the inventory',
      count: 2,
      price: 100.00,
      subtotal: 200.00,
      note:
          'Adding in an interesting comment about what this is and why it’s here. If I need to add more than one line of text, this input grows vertically as needed!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      hasKeyboard: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _locationCard(),
            _tabs(),
          ],
        ),
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

  Widget _locationCard() {
    return AppCardExpandable(
      title: const AppHeaderIcon('Archwood House'),
      subtitle: _locationSubtitle(),
      children: const [
        Icon(
          MdiIcons.beer,
          color: AppColors.primary_60,
          size: 150,
        ),
      ],
    );
  }

  Widget _locationSubtitle() {
    return const Split(
      TextIcon(
        "3486 Archwood house st. vancover, WA 98522",
        MdiIcons.mapMarker,
      ),
      TextKeyVal(
        "Acct. Balance:",
        "\$768.00",
      ),
    );
  }

  Widget _tabs() {
    return AppCardTabs(
        height: 600,
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
        AppBillingLines(data: rowData),
        JobAddNewLine(),
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
