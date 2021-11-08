import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import 'package:louzero/ui/widget/cell/grid/dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(32, 266, 32, 30),
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardCell(
                  title: "Customers",
                  description: "Description...",
                  count: 0,
                  buttonTitleLeft: "ADD CUSTOMER",
                  buttonTitleRight: "VIEW ALL",
                  onPressed: () {
                    NavigationController().pushTo(context, child: const CustomerListPage());
                  },
                  onPressedLeft: () {},
                  onPressedRight: () {},
                ),
              ),
              const SizedBox(width: 24,),
              Expanded(
                child: DashboardCell(
                  title: "Jobs",
                  description: "Description...",
                  count: 0,
                  buttonTitleLeft: " ADD JOB",
                  buttonTitleRight: "VIEW ALL",
                  onPressed: () {},
                  onPressedLeft: () {},
                  onPressedRight: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 100,),
          Row(
            children: [
              Expanded(
                child: DashboardCell(
                  title: "Schedule",
                  description: "Description...",
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 24,),
              Expanded(
                child: DashboardCell(
                  title: "Inventory",
                  description: "Description...",
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 160,),
          Row(
            children: [
              Expanded(
                child: DashboardCell(
                  title: "Reports",
                  description: "Description...",
                  height: 130,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 24,),
              Expanded(
                child: DashboardCell(
                  title: "Settings",
                  description: "Description...",
                  height: 130,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
