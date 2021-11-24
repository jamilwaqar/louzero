import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_list_tile.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';

class ListItem {
  final String title;
  final String? subtitle;
  ListItem({required this.title, this.subtitle}) {}
}

class AccountSetupComplete extends StatelessWidget {
  AccountSetupComplete({
    Key? key,
  }) : super(key: key);

  final welcomText =
      'There are more settings you can adjust for your company but they aren’t critical to getting started with LOUzero. If you choose to wait, you can find these and more via the Settings page at any time. ';

  final List<ListItem> textItems = [
    ListItem(
      title: 'Set up Site Profile Templates',
      subtitle:
          'Keep track of important information about your customer’s location.',
    ),
    ListItem(
      title: 'Set up your Inventory',
      subtitle:
          'Enable quicker billing by defining your common SKUs for quicker billing.   ',
    ),
    ListItem(
      title: 'Set up Users',
      subtitle: 'Invite others to join your team.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          children: [
            const AppTextHeader(
              "Welcome to LOuZero",
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 52, right: 52, bottom: 32),
              child: AppTextBody(
                welcomText,
                center: true,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: textItems.asMap().entries.map((entry) {
                  int idx = entry.key;
                  ListItem item = entry.value;
                  var isOdd = idx % 2 == 0 ? false : true;
                  return AppListTile(
                    title: item.title,
                    subtitle: item.subtitle ?? '',
                    colorBg: isOdd ? Colors.grey.shade50 : Colors.grey.shade200,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
