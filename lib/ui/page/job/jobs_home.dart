import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum SelectCustomerType { none, search, select }

class JobsHome extends StatelessWidget {
  JobsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _tabs(),
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

  Widget _tabs() {
    return AppCardTabs(
        radius: 24,
        children: [
          _tabBilling(),
          const AppTabPanel(children: [
            Text('Job Schedule', style: AppStyles.headerRegular),
          ]),
          const AppTabPanel(children: [
            Text('Billing Line Items', style: AppStyles.headerRegular),
          ]),
        ],
        length: 3,
        tabNames: ['Job Details', 'Schedule', 'Billing']);
  }

  Widget _tabBilling() => AppTabPanel(
        children: [
          Text('Billing Line Items', style: AppStyles.headerRegular),
          Container(
            constraints: BoxConstraints(minHeight: 224, maxHeight: 224),
            width: double.infinity,
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Empty State Illustration',
                      style: AppStyles.headerRegular
                          .copyWith(color: AppColors.secondary_80),
                    ),
                  ),
                ),
                const Text(
                  'You haven\'t added any Billing Lines yet.',
                  style: AppStyles.labelRegular,
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF6F8FA), Colors.white]),
            ),
          ),
          const AppButtons.iconOutline(
            'Add New Line',
            isMenu: true,
          ),
          const AppDivider(),
          const AppButtons.iconFlat('Add Note', icon: MdiIcons.note),
          _dataTable()
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

class AppTabPanel extends StatelessWidget {
  final List<Widget> children;
  final Color color;

  const AppTabPanel(
      {Key? key, this.children = const [], this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
