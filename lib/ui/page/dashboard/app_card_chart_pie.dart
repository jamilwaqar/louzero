import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_row_flex.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/ui/page/dashboard/chart.dart';

import 'chart_list_item.dart';

class AppCardChartPie extends StatelessWidget {
  const AppCardChartPie(
      {Key? key, required this.items, required this.title, this.footer})
      : super(key: key);

  final String title;
  final List<ChartListItem> items;
  final List<Widget>? footer;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      ml: 0,
      mr: 0,
      pl: 16,
      pr: 16,
      pt: 16,
      pb: 16,
      mb: 24,
      children: [
        AppTextHeader(
          title,
          alignLeft: true,
          size: 22,
          mb: 8,
          bold: true,
        ),
        AppRowFlex(
          mb: 16,
          flex: const [1, 1],
          children: [
            Chart(
              items: items,
            ),
            ListView.builder(
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];
                return Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: item.color,
                      size: 10,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.title,
                    )
                  ],
                );
              },
              shrinkWrap: true,
            )
          ],
        ),
        footer != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: footer!,
              )
            : Container(),
      ],
    );
  }
}
