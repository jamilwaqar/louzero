import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/models.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';

class CustomerSiteProfilePage extends StatefulWidget {
  const CustomerSiteProfilePage({Key? key}) : super(key: key);

  @override
  _CustomerSiteProfilePageState createState() => _CustomerSiteProfilePageState();
}

class _CustomerSiteProfilePageState extends State<CustomerSiteProfilePage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _parentAccountNameController = TextEditingController();
  final String _getStartDes =
      "Create Site Profiles to keep track of information common across many customer locations. Examples might include, gate codes, chemical preferences, pool shapes, number of gallons in pool or spa, animals you may encounter, and other site-specific pieces of information not captured elsewhere.";

  bool _showMsg = false;

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
          title: "Site Profile",
          context: context,
          leadingTxt: "Customer Profile",
          hasActions: false,
        ),
        backgroundColor: AppColors.light_1,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _info(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    appIcon(Icons.home_work),
                    const SizedBox(width: 8),
                    Text('Site Profile', style: TextStyles.titleL.copyWith(color: AppColors.dark_2)),
                  ],
                ),
                const SizedBox(height: 24),
                _getStarted(),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select a template below to get started.",
                        style: TextStyles.bodyL.copyWith(
                            color: AppColors.darkest,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text("Not seeing what you need? Create Site Profile Templates in", style: TextStyles.bodyL.copyWith(color: const Color(0xFF3A3E45)),),
                          Text(" Settings → Site Profiles.", style: TextStyles.bodyL.copyWith(color: const Color(0xFF3A3E45), fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _templates(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getStarted() {
    return Container(
          width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.light_1,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appIcon(Icons.lightbulb_outline),
              const SizedBox(width: 8),
              Text('Getting Started', style: TextStyles.headLineS.copyWith(color: AppColors.dark_3)),
            ],
          ),
          const SizedBox(height: 24),
          Text(_getStartDes, style: TextStyles.bodyM.copyWith(color: AppColors.dark_3)),
          const SizedBox(height: 24),
          _notShowMsgWidget(),
          const SizedBox(height: 24),
          _gotItButton(),
        ],
      ),
    );
  }

  Widget _notShowMsgWidget() => Container(
    height: 35,
    alignment: Alignment.centerLeft,
    child: CupertinoButton(
      onPressed: () {
        setState(() {
          _showMsg = !_showMsg;
        });
      },
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
              checkColor: Colors.white,
              value: _showMsg,
              activeColor: AppColors.dark_1,
              onChanged: (val) {
                setState(() {
                  _showMsg = val!;
                });
              }),
          const SizedBox(width: 8),
          const Text("Don't show this message again.", style: TextStyles.bodyL),
        ],
      ),
    ),
  );

  Widget _gotItButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
          child: Container(
            width: 83,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.dark_1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text("Got it", style: TextStyles.labelL.copyWith(color: Colors.white),),
          ),
          onPressed: _gotIt),
    );
  }

  Widget _templates() {
    List<Widget> itemList = List.generate(CTSiteTemplate.values.length,
        (index) => _templateItem(CTSiteTemplate.values[index])).toList();
    itemList.insert(1, const SizedBox(width: 17));
    itemList.insert(3, const SizedBox(width: 17));
    return Row(children: itemList);
  }

  Widget _templateItem(CTSiteTemplate template) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(template.title, style: TextStyles.titleM.copyWith(color: AppColors.dark_1), textAlign: TextAlign.center),
      ),
    );
  }

  void _gotIt() {

  }
}
