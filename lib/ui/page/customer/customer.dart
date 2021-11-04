import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/add_customer.dart';
import 'package:louzero/ui/widget/appbar_action.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';
import 'package:louzero/ui/widget/widget.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({Key? key}) : super(key: key);

  @override
  _CustomerProfilePageState createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _parentAccountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Archwood House",
          context: context,
          leadingTxt: "Customers",
          actions: [
            AppBarAction(
                label: 'Add New',
                onPressed: () => NavigationController()
                    .pushTo(context, child: const AddCustomerPage()))
          ],
        ),
        backgroundColor: AppColors.light_1,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _info(),
              // DashboardCell(
              //   title: "Customer",
              //   description: "Description...",
              //   count: 0,
              //   buttonTitleLeft: "ADD CUSTOMER",
              //   buttonTitleRight: "VIEW ALL",
              //   onPressed: () {},
              //   onPressedLeft: () {},
              //   onPressedRight: () {},
              // ),
              const SizedBox(height: 24),
            ],
          );
        });
  }

  Widget _info() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Archwood House', style: TextStyles.title24),
                          const SizedBox(width: 8),
                          TopLeftButton(onPressed: () {}, iconData: Icons.edit),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('3486 Archwood Ave., Vancouver, Washington 98665', style: TextStyles.title24),
                          appIcon(Icons.attach_money),
                          const SizedBox(width: 3),
                          Text('Acct. Balance:', style:TextStyles.text16.copyWith(color: AppColors.dark_2)),
                          Text("\$0.00:", style: TextStyles.text16.copyWith(color: AppColors.darkest)),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CupertinoButton(
              onPressed: () {  },
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.light_4.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: SvgPicture.asset("${Constant.imgPrefixPath}/icon-up-down.svg"),
              ))
        ],
      ),
    );
  }
}
