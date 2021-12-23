import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/bindings/customer_binding.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();
  final BaseController _baseController = Get.find();

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
          title: "Settings",
          context: context,
          leadingTxt: "Home",
          hasActions: false,
        ),
        backgroundColor: Colors.transparent,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        itemCount: 2,
        itemBuilder: (context, index)=> _listItem(index));
  }

  Widget _listItem(int index) {
    if (index == 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DashboardCell(
            title: "Site Profile Templates",
            description: "Description...",
            count: _baseController.siteProfileTemplates.length,
            buttonTitleLeft: "",
            buttonTitleRight: "",
            onPressed: () => Get.to(()=> CustomerSiteProfilePage(
                _baseController.siteProfileTemplates,
                isTemplate: true), binding: CustomerBinding()),
            onPressedLeft: () {},
            onPressedRight: () {},
          ),
          const SizedBox(height: 24),
        ],
      );
    } else if (index == 1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DashboardCell(
            title: "Companies",
            description: "Description...",
            count: 3,
            buttonTitleLeft: "",
            buttonTitleRight: "",
            onPressed: () => Get.to(()=> const AccountSetup()),
            onPressedLeft: () {},
            onPressedRight: () {},
          ),
          const SizedBox(height: 24),
        ],
      );
    } else  {
      return Container();
    }
  }
}
