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
  final List<chartListItem> items;
  final List<Widget>? footer;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      ml: 0,
      mr: 0,
      pt: 0,
      px: 16,
      py: 16,
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
          flex: [1, 1],
          children: [
            Chart(
              items: items,
            ),
            ListView.builder(
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];
                return Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: item.color,
                      size: 10,
                    ),
                    SizedBox(width: 8),
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
