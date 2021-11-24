import 'package:flutter/cupertino.dart';
import 'package:louzero/bloc/base/base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customers.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<BaseBloc>().add(BaseInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spacing = 24.0;
    var margin = 32.0;
    return BaseScaffold(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: margin, right: margin, top: margin * 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // COLUMN ONE
            Flexible(
              child: Column(
                children: [
                  Image.asset('assets/mocks/jobs-card.png'),
                  SizedBox(height: spacing),
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
                children: [
                  Image.asset('assets/mocks/schedule-card.png'),
                  SizedBox(height: spacing),
                  GestureDetector(
                    child: Image.asset('assets/mocks/customer-card.png'),
                    onTap: () {
                      NavigationController()
                          .pushTo(context, child: const CustomerListPage());
                    },
                  ),
                  SizedBox(height: spacing),
                  Image.asset('assets/mocks/inventory-card.png')
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
