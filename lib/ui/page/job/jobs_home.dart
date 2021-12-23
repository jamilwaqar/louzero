import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card_expandable.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/app_placeholder.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum SelectCustomerType { none, search, select }

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardExpandable(
              title: const AppHeaderIcon('Somewhere or Other'),
              subtitle: _expandSubTitle(),
              children: [_dataTable()],
            ),
            _tabs(),
            // _dataTable(),
          ],
        ),
      ),
      subheader: 'Repair',
      footerEnd: const [
        AppButton(
          fontSize: 16,
          label: 'Job Status',
          icon: MdiIcons.calculator,
          color: AppColors.secondary_20,
          colorIcon: AppColors.accent_1,
        )
      ],
    );
  }

  Widget _expandSubTitle() {
    return AppSplitRow(
      pt: 8,
      start: [
        Icon(
          MdiIcons.mapMarker,
          color: Colors.red,
        ),
        Text("3486 Archwood house st. vancover, WA 98522",
            style: AppStyles.labelBold.copyWith(fontSize: 14))
      ],
      end: [
        Text("Acct. Balance:",
            style: AppStyles.labelRegular.copyWith(fontSize: 14)),
        SizedBox(
          width: 8,
        ),
        Text("\$768.00", style: AppStyles.labelBold.copyWith(fontSize: 14)),
      ],
    );
  }

  Widget _tabs() {
    return Container(
      height: 800,
      child: AppCardTabs(
          radius: 24,
          children: [
            _tabBilling(),
            _tabDetails(),
            _tabSchedule(),
          ],
          length: 3,
          tabNames: ['Job Details', 'Schedule', 'Billing']),
    );
  }

  Widget _tabSchedule() {
    return AppTabPanel(children: [
      Text('Job Schedule', style: AppStyles.headerRegular),
    ]);
  }

  Widget _tabDetails() {
    return AppTabPanel(children: [
      Text('Job Details', style: AppStyles.headerRegular),
    ]);
  }

  Widget _tabBilling() => AppTabPanel(
        children: [
          Text('Billing Line Items', style: AppStyles.headerRegular),
          AppPlaceholder(
            title: 'Empty State Illustration',
            subtitle: 'Add some billing line items to start.',
          ),
          const AppButtons.iconOutline(
            'Add New Line',
            isMenu: true,
          ),
          const AppDivider(),
          const AppButtons.iconFlat('Add Note', icon: MdiIcons.note),
        ],
      );

  Widget _dataTable() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondary_90),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, AppColors.secondary_99]),
      ),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      constraints: BoxConstraints(minHeight: 200),
      child: _totalTable());

  Widget _totalTable() {
    final columns = ['Description', 'Qty.', 'Price', 'Subtotal'];
    return DataTable(columns: getColumns(columns), rows: getRows(rowData));
  }

  final rowData = <LineItem>[
    LineItem(
        description: 'Clean Pool', count: 1, price: 50.00, subtotal: 50.00),
    LineItem(
        description: 'Replace Valve Seals',
        count: 4,
        price: 5.00,
        subtotal: 20.00),
    LineItem(
        description: 'Replace Valve Seals',
        count: 1,
        price: 16.48,
        subtotal: 16.48),
  ];

  List<DataRow> getRows(List<LineItem> items) {
    return items.map((LineItem item) {
      final cells = [item.description, item.count, item.price, item.subtotal];
      return DataRow(cells: getCells(cells));
    }).toList();
  }

  List<DataCell> getCells(List<dynamic> cells) {
    return cells
        .map((data) => DataCell(Text('$data', style: AppStyles.labelBold)))
        .toList();
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(label: Text(column));
    }).toList();
  }
}

class LineItem {
  final String description;
  final double count;
  final double price;
  final double subtotal;
  const LineItem(
      {required this.description,
      required this.count,
      required this.price,
      required this.subtotal});

  LineItem copy({
    String? description,
    double? count,
    double? price,
    double? subtotal,
  }) =>
      LineItem(
        description: description ?? this.description,
        count: count ?? this.count,
        price: price ?? this.price,
        subtotal: subtotal ?? this.subtotal,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineItem &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          count == other.count &&
          price == other.price &&
          subtotal == other.subtotal;

  @override
  int get hashCode =>
      description.hashCode ^
      count.hashCode ^
      price.hashCode ^
      subtotal.hashCode;
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
