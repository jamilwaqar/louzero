import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/bindings/customer_binding.dart';
import 'package:louzero/controller/get/bindings/job_binding.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import 'package:louzero/ui/page/job/add_job.dart';
import 'package:louzero/ui/page/job/jobs.dart';
import 'package:louzero/ui/page/job/views/jobs_home.dart';
import 'app_card_chart_pie.dart';
import 'chart_list_item.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

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

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final BaseController _baseController = Get.find();
  @override
  void initState() {
    _baseController.fetchInitialData();
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // COLUMN ONE
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppCardChartPie(
                items: widget.chartDataJobs,
                title: 'Jobs',
                footer: [
                  AppButton(
                    fontSize: btnSize,
                    height: btnHeight,
                    margin: const EdgeInsets.only(right: 8),
                    label: 'Dev Page',
                    colorBg: Colors.red,
                    borderColor: Colors.red,
                    primary: false,
                    onPressed: () =>
                        Get.to(() => JobsHome(), binding: JobBinding()),
                  ),
                  AppButton(
                    fontSize: btnSize,
                    height: btnHeight,
                    margin: const EdgeInsets.only(right: 8),
                    label: 'Add Job',
                    colorBg: AppColors.dark_1,
                    colorText: AppColors.darkest,
                    primary: false,
                    onPressed: () =>
                        Get.to(() => AddJobPage(), binding: JobBinding()),
                  ),
                  AppButton(
                      fontSize: btnSize,
                      height: btnHeight,
                      colorBg: AppColors.dark_1,
                      label: 'Search Jobs',
                      onPressed: () {
                        Get.to(() => const JobListPage(),
                            binding: JobBinding());
                      })
                ],
              ),
              Image.asset('assets/mocks/reports-card.png'),
              SizedBox(height: spacing),
              Image.asset('assets/mocks/payments-card.png')
            ],
          ),
        ),
        SizedBox(width: spacing),
        // COLUMN TWO
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/mocks/schedule-card.png'),
              SizedBox(height: spacing),
              AppCardChartPie(
                  items: widget.chartDataCustomer,
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
                      onPressed: () => Get.to(() => const CustomerListPage(), binding: CustomerBinding()),
                    )
                  ]),
              SizedBox(height: spacing),
              Image.asset('assets/mocks/inventory-card.png')
            ],
          ),
        ),
      ],
    );
  }
}
