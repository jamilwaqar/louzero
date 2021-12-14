import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/customer/customer_site.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController =
      TextEditingController();
  late BaseBloc _baseBloc;
  
  @override
  void initState() {
    _baseBloc = context.read<BaseBloc>();
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
    return BlocBuilder<BaseBloc, BaseState>(
      bloc: _baseBloc,
      builder: (context, state) {
        return BaseScaffold(
          child: Scaffold(
            appBar: SubAppBar(
              title: "Settings",
              context: context,
              leadingTxt: "Home",
              hasActions: false,
            ),
            backgroundColor: Colors.transparent,
            body: _body(state),
          ),
        );
      }
    );
  }

  Widget _body(BaseState state) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        itemCount: 2,
        itemBuilder: (context, index)=> _listItem(state, index));
  }

  Widget _listItem(BaseState state, int index) {
    if (index == 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DashboardCell(
            title: "Site Profile Templates",
            description: "Description...",
            count: state.siteProfileTemplates.length,
            buttonTitleLeft: "",
            buttonTitleRight: "",
            onPressed: () => NavigationController().pushTo(context,
                child: CustomerSiteProfilePage(
                    CustomerBloc(_baseBloc),
                    state.siteProfileTemplates,
                    isTemplate: true)),
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
            onPressed: () => Get.to(()=> AccountSetup()),
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
