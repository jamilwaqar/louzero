import 'package:flutter/material.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_inline_form.dart';
import 'package:louzero/common/app_list_draggable.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';

class AccountSetupCustomers extends StatefulWidget {
  const AccountSetupCustomers({Key? key}) : super(key: key);

  @override
  State<AccountSetupCustomers> createState() => _AccountSetupCustomersState();
}

class _AccountSetupCustomersState extends State<AccountSetupCustomers> {
  final _customerTypeController = TextEditingController();
  final List<String> _customerTypes = [
    "Residential",
    "Commerical",
    "Volunteer",
  ];

  @override
  void initState() {
    super.initState();
  }

  void addItemToCustomerTypes(String newItem) {
    if (newItem.isNotEmpty) {
      setState(() {
        _customerTypes.add(newItem);
      });
    }
  }

  final customerTypeText =
      'Customer Types allow for categorization of customers. Common options are residential and commercial. This categorization will be helpful in reporting on performance.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCard(
          children: [
            const AppTextHeader(
              "Customer Types",
              alignLeft: true,
              icon: Icons.people,
              size: 24,
            ),
            AppTextBody(customerTypeText),
            AppListDraggable(
              items: _customerTypes,
            ),
            const Divider(
              color: AppColors.light_3,
            ),
            AppInputInlineForm(
              mt: 14,
              controller: _customerTypeController,
              label: 'Add new Customer Type',
              btnLabel: 'ADD',
              onPressed: () {
                addItemToCustomerTypes(_customerTypeController.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}
