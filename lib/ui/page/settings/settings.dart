import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:louzero/bloc/bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DashboardCell(
                title: "Site Profile Templates",
                description: "Description...",
                count: 3,
                buttonTitleLeft: "",
                buttonTitleRight: "",
                onPressed: () => NavigationController()
                    .pushTo(context, child: CustomerSiteProfilePage(CustomerBloc(context.read<BaseBloc>()), isTemplate: true)),
                onPressedLeft: () {},
                onPressedRight: () {},
              ),
              const SizedBox(height: 24),
            ],
          );
        });
  }
}
