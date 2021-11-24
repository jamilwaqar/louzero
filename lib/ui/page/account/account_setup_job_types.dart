import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';

class AccountSetupJobTypes extends StatelessWidget {
  AccountSetupJobTypes({Key? key}) : super(key: key);

  final TextEditingController _controlTBD = TextEditingController();
  final jobTypeText =
      'Save time by profiling your common job types. Think about repairs, sales and recurring services. Later, you can build out full templates for each job type in Settings.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          children: [
            const AppTextHeader(
              "Job Types",
              alignLeft: true,
              icon: Icons.business_center_sharp,
              size: 24,
            ),
            AppTextBody(jobTypeText),
            const AppTextBody(
              "IN PROGRESS",
              mt: 48,
              color: Colors.red,
            )
          ],
        ),
      ],
    );
  }
}
