import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/bindings/customer_binding.dart';
import 'package:louzero/controller/get/bindings/job_binding.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import 'package:louzero/ui/page/job/add_job.dart';
import 'package:louzero/ui/page/job/jobs.dart';
import 'package:louzero/ui/page/stub/stub_nav.dart';
import 'package:louzero/ui/page/stub/views/stub_view_starter.dart';
import 'package:louzero/ui/page/stub/views/stub_view_counter.dart';
import 'app_card_chart_pie.dart';
import 'chart_list_item.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    Get.find<BaseController>().fetchInitialData();
    super.initState();
  }

  double btnSize = 13;
  double btnHeight = 34;

  @override
  Widget build(BuildContext context) {
    var margin = 32.0;
    return AppBaseScaffold(
        subheader: 'Dashboard',
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: margin, right: margin, top: margin * 2),
            child: _body(),
          ),
        ));
  }

  Widget _body() {
    var spacing = 24.0;
    return FlexRow(
      children: [
        // COLUMN ONE
        Column(
          children: [
            customerChart(),
            jobsChart(),
            SizedBox(height: spacing),
          ],
        ),
        // COLUMN TWO
        Column(
          children: [
            _dashboardCard(
              'In Development',
              desc:
                  'Links to App Widgets in progress. For internal use and demos:',
              children: [StubNav()],
            ),
            _dashboardCard('Inventory'),
            _dashboardCard('Account Settings'),
            SizedBox(height: spacing),
          ],
        ),
      ],
    );
  }

  Widget _dashboardCard(String title,
      {List<Widget> children = const [],
      desc =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempo'}) {
    return AppCard(
      radius: 8,
      mx: 0,
      mt: 0,
      pt: 16,
      pb: 24,
      children: [
        Text(title, style: AppStyles.headerDialog),
        SizedBox(height: 4),
        Text(desc, style: AppStyles.bodyLarge),
        ...children
      ],
    );
  }

  Widget customerChart() {
    final List<ChartListItem> chartDataCustomer = [
      ChartListItem(
        title: 'Total Customers',
        color: AppColors.dark_2,
        subtitle: '(172)',
        amount: 30,
      ),
      ChartListItem(
        title: 'Active this Month',
        color: AppColors.medium_3,
        subtitle: '(34)',
        amount: 60,
      ),
    ];
    return AppCardChartPie(
        items: chartDataCustomer,
        title: 'Customers',
        footer: [
          AppButton(
            fontSize: btnSize,
            height: btnHeight,
            margin: const EdgeInsets.only(right: 8),
            label: 'Add Customer',
            colorBg: AppColors.dark_1,
            colorText: AppColors.darkest,
            primary: false,
          ),
          AppButton(
            fontSize: btnSize,
            height: btnHeight,
            colorBg: AppColors.dark_1,
            label: 'View All',
            onPressed: () => Get.to(() => const CustomerListPage(),
                binding: CustomerBinding()),
          )
        ]);
  }

  Widget jobsChart() {
    final List<ChartListItem> chartDataJobs = [
      ChartListItem(
        title: 'Booked Solid',
        color: AppColors.dark_2,
        subtitle: '(27)',
        amount: 10,
      ),
      ChartListItem(
        title: 'Estimate',
        color: AppColors.medium_3,
        subtitle: '(20)',
        amount: 20,
      ),
      ChartListItem(
        title: 'Invoiced',
        color: AppColors.light_3,
        subtitle: '(7 this month)',
        amount: 10,
      ),
      ChartListItem(
        title: 'Canceled',
        color: AppColors.light_3.withOpacity(0.5),
        subtitle: '(2 this month)',
        amount: 5,
      )
    ];

    return AppCardChartPie(
      items: chartDataJobs,
      title: 'Jobs',
      footer: [
        AppButton(
          fontSize: btnSize,
          height: btnHeight,
          margin: const EdgeInsets.only(right: 8),
          label: 'Add Job',
          colorBg: AppColors.dark_1,
          colorText: AppColors.darkest,
          primary: false,
          onPressed: () => Get.to(() => AddJobPage(), binding: JobBinding()),
        ),
        AppButton(
            fontSize: btnSize,
            height: btnHeight,
            colorBg: AppColors.dark_1,
            label: 'Search Jobs',
            onPressed: () {
              Get.to(() => const JobListPage(), binding: JobBinding());
            })
      ],
    );
  }
}
