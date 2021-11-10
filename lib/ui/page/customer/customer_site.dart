import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/widget.dart';

class CustomerSiteProfilePage extends StatefulWidget {
  const CustomerSiteProfilePage({Key? key}) : super(key: key);

  @override
  _CustomerSiteProfilePageState createState() => _CustomerSiteProfilePageState();
}

class _CustomerSiteProfilePageState extends State<CustomerSiteProfilePage> {
  final TextEditingController _profileNameController = TextEditingController();
  TextEditingController _addNewLabelController = TextEditingController();
  TextEditingController _addNewValueController = TextEditingController();

  List<TextEditingController> _profileItemLabelControllers = [];
  List<TextEditingController> _profileItemValueControllers = [];

  final String _getStartDes =
      "Create Site Profiles to keep track of information common across many customer locations. Examples might include, gate codes, chemical preferences, pool shapes, number of gallons in pool or spa, animals you may encounter, and other site-specific pieces of information not captured elsewhere.";
  List<CTSiteProfile>profiles = [];
  bool _showMsg = false;
  bool _isEditing = false;

  @override
  void initState() {
    _profileItemLabelControllers = List.generate(4, (index) => TextEditingController());
    _profileItemValueControllers = List.generate(4, (index) => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    _profileNameController.dispose();
    _addNewLabelController.dispose();
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
                    Expanded(child: Text('Site Profile', style: TextStyles.titleL.copyWith(color: AppColors.dark_2))),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.light_1),
                        child: appIcon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _mainWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mainWidget() {
    if (_isEditing) {
      return _addSiteWidget();
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      );
    }
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
      child: CupertinoButton(
        onPressed: ()=> setState(() {_isEditing = true;}),
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
      ),
    );
  }

  void _gotIt() {

  }

  Widget _addSiteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Flexible(
                child: LZTextField(
                  controller: _profileNameController,
                  label: 'Site Profile Name*',
                ),
              ),
              const Flexible(child: SizedBox()),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Divider(thickness: 1),
        const SizedBox(height: 24),
        _infoInputList(),
        const SizedBox(height: 24),
        const Divider(thickness: 1),
        const SizedBox(height: 32),
        _saveOrCancel()
      ],
    );
  }

  Widget _infoInputList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _reorderList(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 56),
            Flexible(child: LZTextField(controller: _addNewLabelController, label: "Add New Label")),
            const SizedBox(width: 16),
            Flexible(child: LZTextField(controller: _addNewValueController, label: "Add New Value")),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.medium_1, width: 1),
                    color: AppColors.lightest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("ADD",
                      style:
                          TextStyles.titleM.copyWith(color: AppColors.dark_3),
                      textAlign: TextAlign.center),
                ),
                onPressed: () {
                  _profileItemLabelControllers.add(_addNewLabelController);
                  _profileItemValueControllers.add(_addNewValueController);
                  _addNewLabelController = TextEditingController();
                  _addNewValueController = TextEditingController();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  final Color _oddItemColor = AppColors.light_1.withOpacity(0.7);
  final Color _evenItemColor = AppColors.light_2.withOpacity(0.4);
  Widget _reorderList() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ReorderableListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int index = 0; index < _profileItemLabelControllers.length; index++)
            Container(
              key: Key('$index'),
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 8 : 0),
                    topRight: Radius.circular(index == 0 ? 8 : 0),
                    bottomLeft: Radius.circular(index == _profileItemLabelControllers.length - 1 ? 8 : 0),
                    bottomRight: Radius.circular(index == _profileItemLabelControllers.length - 1 ? 8 : 0)),
                color: index.isOdd ? _oddItemColor : _evenItemColor,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  appIcon(Icons.menu, color: AppColors.medium_2),
                  const SizedBox(width: 16),
                  Expanded(child: _textField(_profileItemLabelControllers[index])),
                  const SizedBox(width: 16),
                  Expanded(child: _textField(_profileItemValueControllers[index])),
                  const SizedBox(width: 32),
                  InkWell(
                      onTap: () {
                        _profileItemLabelControllers.removeAt(index);
                        _profileItemValueControllers.removeAt(index);
                        setState(() {});
                      },
                      child: appIcon(Icons.delete, color: AppColors.medium_2),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final TextEditingController itemLabel = _profileItemLabelControllers.removeAt(oldIndex);
            _profileItemLabelControllers.insert(newIndex, itemLabel);
            final TextEditingController itemValue = _profileItemValueControllers.removeAt(oldIndex);
            _profileItemValueControllers.insert(newIndex, itemValue);
          });
        },
      ),
    );
  }

  Widget _textField(TextEditingController controller) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.light_3, width: 1),
        color: Colors.white
      ),
      child: TextFormField(
        controller: controller,
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.dark_3),
      ),
    );
  }

  Widget _saveOrCancel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
              child: Container(
                width: 192,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.dark_1,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text("Save Site Profile", style: TextStyles.bodyL.copyWith(color: Colors.white),),
              ),
              onPressed: _save),
          const SizedBox(width: 8),
          CupertinoButton(
              child: Container(
                width: 125,
                height: 56,
                alignment: Alignment.center,
                child: const Text("CANCEL", style: TextStyles.bodyL),
              ),
              onPressed: () {
                NavigationController().pop(context);
              }),
        ],
      ),
    );
  }

  void _save() {
    CTSiteProfile profile = CTSiteProfile();
    profile.name = _profileNameController.text;
    for (int i = 0; i < _profileItemLabelControllers.length; i++) {
      String label = _profileItemLabelControllers[i].text;
      if (label.isEmpty) continue;
      profile.profiles[label] = _profileItemValueControllers[i].text;
    }

    setState(() {
      profiles.add(profile);
    });
  }
}
