import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_inline_form.dart';
import 'package:louzero/common/app_list_draggable.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';

class AccountSetupJobTypes extends StatefulWidget {
  const AccountSetupJobTypes({Key? key}) : super(key: key);

  @override
  State<AccountSetupJobTypes> createState() => _AccountSetupJobTypesState();
}

class _AccountSetupJobTypesState extends State<AccountSetupJobTypes> {
  final TextEditingController _jobTypes = TextEditingController();

  final jobTypeText =
      'Save time by profiling your common job types. Think about repairs, sales and recurring services. Later, you can build out full templates for each job type in Settings.';

  final _customerTypes = ['Residential', 'Commercial'];

  void addItemToCustomerTypes(String newItem) {
    if (newItem.isNotEmpty) {
      setState(() {
        _customerTypes.add(newItem);
      });
    }
  }

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
            AppTextBody(jobTypeText, mb: 24),
            AppListDraggable(
              items: _customerTypes,
            ),
            const Divider(
              color: AppColors.light_3,
            ),
            AppInputInlineForm(
              mt: 14,
              controller: _jobTypes,
              label: 'Add new Job Type',
              btnLabel: 'ADD',
              onPressed: () {
                addItemToCustomerTypes(_jobTypes.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}
