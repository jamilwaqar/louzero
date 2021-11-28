import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_dropdown_multiple.dart';
import 'package:louzero/common/app_dropdown_search.dart';
import 'package:louzero/common/app_input_inline_form.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_list_draggable.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class AccountStart extends StatefulWidget {
  const AccountStart({Key? key}) : super(key: key);

  @override
  _AccountStartState createState() => _AccountStartState();
}

class _AccountStartState extends State<AccountStart> {
  final _controlTBD = TextEditingController();
  final _addCustomerTypeController = TextEditingController();

  final _jobTypes = [
    "Repair",
    "Sale",
    "Discount",
  ];
  final _customerTypes = [
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

  void addItemToJobTypes(String newItem) {
    if (newItem.isNotEmpty) {
      setState(() {
        _jobTypes.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: const [
                  AppTextHeader(
                    "To start, let’s get some basic info.",
                    mt: 32,
                    mb: 8,
                  ),
                  AppTextBody(
                    'You can always make changes later in Settings',
                    mb: 32,
                    bold: true,
                  ),
                ],
              )),
          Expanded(
            flex: 3,
            child: PageView(
              physics: const BouncingScrollPhysics(),
              children: [
                _CompanyDetails(controlTBD: _controlTBD),
                _AccountCustomers(
                  controlTBD: _addCustomerTypeController,
                  customerTypes: _customerTypes,
                  onBtnClickFunction: () {
                    addItemToCustomerTypes(_addCustomerTypeController.text);
                  },
                ),
                _AccountJobTypes(controlTBD: _controlTBD),
                _SetupComplete(controlTBD: _controlTBD),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ListItem {
  final String title;
  final String? subtitle;
  ListItem({required this.title, this.subtitle});
}

class _SetupComplete extends StatelessWidget {
  _SetupComplete({
    Key? key,
    required TextEditingController controlTBD,
  })  : _controlTBD = controlTBD,
        super(key: key);

  final TextEditingController _controlTBD;
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
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
                      colorBg:
                          isOdd ? Colors.grey.shade50 : Colors.grey.shade200,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const AppButtonSubmit(),
        ],
      ),
    );
  }
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.colorBg = AppColors.light_1,
    this.iconStart = Icons.radio_button_off,
    this.iconEnd = Icons.chevron_right_sharp,
    this.mt = 0,
    this.mb = 0,
    this.mr = 0,
    this.ml = 0,
    this.onTap,
  }) : super(key: key);

  final IconData iconStart;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final IconData iconEnd;
  final Color colorBg;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: ml, right: mr, top: mt, bottom: mb),
      elevation: 0,
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(iconStart),
        ),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(title),
        ),
        subtitle: subtitle != ''
            ? Transform.translate(
                offset: const Offset(-16, 0),
                child: Text(subtitle),
              )
            : null,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        trailing: SizedBox(
          height: double.infinity,
          child: Icon(iconEnd),
        ),
        tileColor: colorBg,
      ),
    );
  }
}

class _AccountJobTypes extends StatelessWidget {
  const _AccountJobTypes({
    Key? key,
    required TextEditingController controlTBD,
  })  : _controlTBD = controlTBD,
        super(key: key);

  final TextEditingController _controlTBD;
  final jobTypeText =
      'Save time by profiling your common job types. Think about repairs, sales and recurring services. Later, you can build out full templates for each job type in Settings.';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 32),
      child: Column(
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
              AppInputText(
                  mt: 14,
                  controller: _controlTBD,
                  label: 'What Industries do you serve?'),
            ],
          ),
          const AppButtonSubmit(),
        ],
      ),
    );
  }
}

class _AccountCustomers extends StatelessWidget {
  const _AccountCustomers({
    Key? key,
    required TextEditingController controlTBD,
    required List<String> customerTypes,
    required VoidCallback onBtnClickFunction,
  })  : _controlTBD = controlTBD,
        _customerTypes = customerTypes,
        _onBtnClickFunction = onBtnClickFunction,
        super(key: key);

  final TextEditingController _controlTBD;
  final List<String> _customerTypes;
  final VoidCallback _onBtnClickFunction;
  final customerTypeText =
      'Customer Types allow for categorization of customers. Common options are residential and commercial. This categorization will be helpful in reporting on performance.';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 32),
      child: Column(
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
                controller: _controlTBD,
                label: 'Add new Customer Type',
                btnLabel: 'ADD',
                onPressed: _onBtnClickFunction,
              ),
            ],
          ),
          const AppButtonSubmit(),
        ],
      ),
    );
  }
}

class _CompanyDetails extends StatelessWidget {
  _CompanyDetails({
    Key? key,
    required TextEditingController controlTBD,
  })  : _controlTBD = controlTBD,
        super(key: key);

  final TextEditingController _controlTBD;
  final TextEditingController _streetAddressDropdownSearchControl =
      TextEditingController();
  final ScrollController _companyDetailsScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _companyDetailsScrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 132,
      ),
      child: Column(
        children: [
          AppCard(
            children: [
              const AppTextHeader(
                "Company Details",
                alignLeft: true,
                icon: Icons.home_work_sharp,
                size: 24,
              ),
              AppFlexRow(
                children: [
                  AppFlexColumn(children: [
                    AppInputText(
                      required: true,
                      controller: _controlTBD,
                      label: 'Company Name',
                    ),
                    AppInputText(
                      controller: _controlTBD,
                      label: 'Website',
                    ),
                  ]),
                  AppFlexColumn(ml: 16, children: [
                    AppInputText(
                      controller: _controlTBD,
                      required: true,
                      label: 'Phone Number',
                    ),
                    AppInputText(
                      controller: _controlTBD,
                      label: 'Email Address',
                    )
                  ])
                ],
              ),
              const Divider(
                color: AppColors.light_3,
              ),
              AppDropdownMultiple(
                  controller: _controlTBD,
                  label: 'What Industries do you serve?'),
            ],
          ),
          AppCard(
            mt: 24,
            children: [
              const AppTextHeader(
                "Company Address",
                alignLeft: true,
                icon: Icons.location_on,
                size: 24,
              ),
              AppInputText(
                controller: _controlTBD,
                label: 'Country',
              ),
              AppDropdownSearch(
                controller: _streetAddressDropdownSearchControl,
                parentScrollController: _companyDetailsScrollController,
                label: 'Street Address',
              ),
              AppInputText(
                controller: _controlTBD,
                label: 'Apt / Suite / Other',
                colorBg: AppColors.light_1,
              ),
              AppFlexRow(
                children: [
                  AppFlexColumn(flex: 2, children: [
                    AppInputText(
                      controller: _controlTBD,
                      label: 'City',
                      colorBg: AppColors.light_1,
                    ),
                  ]),
                  AppFlexColumn(ml: 16, children: [
                    AppInputText(
                      controller: _controlTBD,
                      label: 'State',
                      colorBg: AppColors.light_1,
                    ),
                  ]),
                  AppFlexColumn(ml: 16, children: [
                    AppInputText(
                      controller: _controlTBD,
                      label: 'Zip',
                      colorBg: AppColors.light_1,
                    ),
                  ]),
                ],
              ),
            ],
          ),
          const AppButtonSubmit(),
        ],
      ),
    );
  }
}

class AppButtonSubmit extends StatelessWidget {
  const AppButtonSubmit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppDivider(ml: 24, mr: 24, mb: 24),
        Row(
          children: const [
            AppButton(
              ml: 24,
              mb: 48,
              label: 'Save & Continue',
              color: AppColors.dark_2,
            )
          ],
        )
      ],
    );
  }
}

Widget buildBasicListView() => ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text('Favourites'),
          subtitle: Text('All your favourite widgets'),
          trailing: Icon(Icons.star, color: Colors.orange),
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text('High Ranked'),
          subtitle: Text('All widgets liked by the community'),
          trailing: Icon(Icons.mood, color: Colors.blue),
        ),
        ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text('Important'),
          subtitle: Text('All widgets that are important to know'),
          trailing: Icon(Icons.assistant_photo, color: Colors.black),
        ),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Colors.red),
          title: Text('Deleted'),
        ),
      ],
    );

class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
    this.mt = 0,
    this.mb = 24,
    this.ml = 0,
    this.mr = 0,
    this.color = AppColors.light_3,
    this.size = 2,
  }) : super(key: key);

  final double mt;
  final double mb;
  final double ml;
  final double mr;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: mt,
        bottom: mb,
        left: ml,
        right: mr,
      ),
      child: Divider(
        color: color,
        thickness: size,
        height: size,
      ),
    );
  }
}

class AppFlexRow extends StatelessWidget {
  const AppFlexRow({
    Key? key,
    required this.children,
    this.mt = 0,
    this.mb = 0,
  }) : super(key: key);

  final List<Widget> children;
  final double mt;
  final double mb;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class AppFlexColumn extends StatelessWidget {
  const AppFlexColumn({
    Key? key,
    required this.children,
    this.ml = 0,
    this.mr = 0,
    this.flex = 1,
  }) : super(key: key);

  final List<Widget> children;
  final double ml;
  final double mr;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: ml, right: mr),
        child: Column(
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}
