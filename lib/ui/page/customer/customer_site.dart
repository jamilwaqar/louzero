import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/bloc/bloc.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/buttons/top_left_button.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerSiteProfilePage extends StatefulWidget {

  final bool isTemplate;
  final String? customerId;
  final CustomerBloc customerBloc;
  final List<CTSiteProfile> siteProfiles;
  const CustomerSiteProfilePage(this.customerBloc, this.siteProfiles,
      {this.customerId, this.isTemplate = false, Key? key}) : super(key: key);

  @override
  _CustomerSiteProfilePageState createState() => _CustomerSiteProfilePageState();
}

enum ExpandState { expanded, collapsed }

class _CustomerSiteProfilePageState extends State<CustomerSiteProfilePage> {
  final TextEditingController _profileNameController = TextEditingController();
  TextEditingController _addNewLabelController = TextEditingController();
  TextEditingController _addNewValueController = TextEditingController();

  List<TextEditingController> _profileItemLabelControllers = [];
  List<TextEditingController> _profileItemValueControllers = [];

  final String _getStartDes =
      "Create Site Profiles to keep track of information common across many customer locations. Examples might include, gate codes, chemical preferences, pool shapes, number of gallons in pool or spa, animals you may encounter, and other site-specific pieces of information not captured elsewhere.";

  final _showMsg = false.obs;
  bool _isEditing = false;
  late bool _showGetStarted;
  bool _isAdding = false;
  late bool _isTemplate;
  late CTSiteProfile _customTemplate;
  final List<ExpandState> _expandedList = [];
  List<CTSiteProfile> _siteProfiles = [];
  final BaseController _baseController = Get.find();
  @override
  void initState() {
    _initTextControllers();
    _isTemplate = widget.isTemplate;
    _siteProfiles = widget.siteProfiles;
    _setExpanded(_siteProfiles);
    _customTemplate = CTSiteProfile(name: 'Custom', customerId: widget.customerId);
    _showGetStarted = GetStorage().read(GSKey.showGetStartedSiteProfile) ?? true;
    super.initState();
  }

  void _setExpanded(List<CTSiteProfile> siteProfiles) {
    for (var _ in siteProfiles) {
      _expandedList.add(ExpandState.collapsed);
    }
  }

  @override
  void dispose() {
    _profileNameController.dispose();
    _addNewLabelController.dispose();
    super.dispose();
  }

  void _initTextControllers() {
    _profileItemLabelControllers = List.generate(4, (index) => TextEditingController());
    _profileItemValueControllers = List.generate(4, (index) => TextEditingController());
  }

  bool listenWhen(CustomerState preState, CustomerState state) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      bloc: widget.customerBloc,
      listenWhen: listenWhen,
      listener: (BuildContext context, CustomerState state) {

      },
      child: BlocBuilder<CustomerBloc, CustomerState>(
        bloc: widget.customerBloc,
        builder: (context, state) {
          return BaseScaffold(
            child: Scaffold(
              appBar: SubAppBar(
                title: _isTemplate ? "Site Profile Templates" : "Site Profile",
                context: context,
                leadingTxt: _isTemplate ? "Settings" : "Customer Profile",
                hasActions: _isAdding,
                actions: [
                  if (!_isAdding)
                  _addNew()
                ],
              ),
              backgroundColor: Colors.transparent,
              body: _body(),
            ),
          );
        }
      ),
    );
  }

  Widget _body() {
    if (_isAdding) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _addProfile();
        },
        itemCount: 1,
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shrinkWrap: true,
        separatorBuilder: (_, __) {
          return const Divider(height: 16, color: Colors.transparent);
        },
        itemBuilder: (context, index) {
          return _profileItem(index);
        },
        itemCount: _siteProfiles.length,
      );
    }
  }

  Widget _addNew() {
    String label = _isTemplate ? "Add Template" : "Add Site Profile";
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(right: 32.0),
      child: CupertinoButton(
        onPressed: () {
          _initTextControllers();
          setState(() {
            _isAdding = true;
            if (!_showGetStarted) {
              _isEditing = true;
            }
          });
        },
        padding: EdgeInsets.zero,
        child: Container(
          height: 40,
          width: 165,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.lightest,
              border: Border.all(color: AppColors.dark_3),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appIcon(Icons.add_circle),
              const SizedBox(width: 8),
              Text(label, style: TextStyles.labelL),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileItem(int index) {
    CTSiteProfile profile = _siteProfiles[index];
    bool isExpanded = _expandedList[index] == ExpandState.expanded;
    String expandCollapse = !isExpanded
        ? "${Constant.imgPrefixPath}/icon-expand.svg"
        : "${Constant.imgPrefixPath}/icon-collapse.svg";
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
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
                              Text(profile.name, style: TextStyles.headLineS.copyWith(color: AppColors.dark_2)),
                              const SizedBox(width: 8),
                              TopLeftButton(onPressed: () {}, iconData: Icons.edit),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CupertinoButton(
                  onPressed: () {
                    ExpandState newState = isExpanded ? ExpandState.collapsed : ExpandState.expanded;
                    setState(() {
                      _expandedList[index] = newState;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.light_4.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: SvgPicture.asset(expandCollapse),
                  ),)
            ],
          ),
          if (isExpanded)
            ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profile.profiles.length,
            itemBuilder: (context, index) {
              String label = profile.profiles.keys.toList()[index];
              String? value = profile.profiles[label];
              return Container(
                key: Key('$index'),
                width: double.infinity,
                height: 48,
                color: index.isOdd ? _oddItemColor : _evenItemColor,
                child: Row(
                  children: [
                    const SizedBox(width: 56),
                    Expanded(
                      child: Text(
                        label,
                        style:
                            TextStyles.bodyL.copyWith(color: AppColors.dark_3),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text(
                      value ?? '-- --',
                      style:
                      TextStyles.bodyL.copyWith(color: AppColors.dark_3),
                    )),

                    const SizedBox(width: 32),
                  ],
                ),
              );
            },),
          if (isExpanded)
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _addProfile() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    Expanded(child: Text(_isTemplate ? "Add Template" : "Site Profile", style: TextStyles.titleL.copyWith(color: AppColors.dark_2))),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _isAdding = false;
                          _isEditing = false;
                        });
                      },
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
          if (_showGetStarted)
          _getStarted(),
          if (!_isTemplate)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
        _showMsg.value = !_showMsg.value;
        _showGetStarted = !_showMsg.value;
        GetStorage().write(GSKey.showGetStartedSiteProfile, _showGetStarted);
      },
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(()=> Checkbox(
              checkColor: Colors.white,
              value: _showMsg.value,
              activeColor: AppColors.dark_1,
              onChanged: (val) {
                  _showMsg.value = val!;
              }),),
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
        padding: EdgeInsets.zero,
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
    List<CTSiteProfile>profiles = [... _baseController.siteProfileTemplates.value];
    profiles.add(_customTemplate);
    List<Widget> itemList = List.generate(profiles.length,
        (index) => _templateItem(profiles[index])).toList();
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 17,
      mainAxisSpacing: 17,
      shrinkWrap: true,
      children: itemList,
      childAspectRatio: 4/3,
    );
  }

  Widget _templateItem(CTSiteProfile template) {
    return CupertinoButton(
      onPressed: () {
        if (template.name != 'Custom') {
          _profileNameController.text = template.name;

          _profileItemLabelControllers = [];
          _profileItemValueControllers = [];
          for (int i = 0; i < template.profiles.keys.length; i++) {
            String key = template.profiles.keys.toList()[i];
            String? value = template.profiles[key];
            _profileItemLabelControllers.add(TextEditingController(text: key));
            _profileItemValueControllers.add(TextEditingController(text: value));
          }
          /// Add empty one
          _profileItemLabelControllers.add(TextEditingController());
          _profileItemValueControllers.add(TextEditingController());
        }

        setState(() {
          _isEditing = true;
        });
      },
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(template.name, style: TextStyles.titleM.copyWith(color: AppColors.dark_1), textAlign: TextAlign.center),
      ),
    );
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
                child: AppInputText(
                  controller: _profileNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  mb: 32,
                  label: _isTemplate ? "Template Name*" :"Site Profile Name*",
                ),
              ),
              const Flexible(child: SizedBox()),
            ],
          ),
        ),
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
        SizedBox(
          width: double.infinity,
          height: 48,
          child: Row(
            children: [
              const SizedBox(width: 56),
              Expanded(
                child: Text(
                  "Label",
                  style:
                  TextStyles.bodyL.copyWith(color: AppColors.dark_3),
                ),
              ),
              Expanded(child: Text(
                "Default Value",
                style:
                TextStyles.bodyL.copyWith(color: AppColors.dark_3),
              )),
              const SizedBox(width: 56),
            ],
          ),
        ),
        _reorderList(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 56),
            Flexible(child: AppInputText(controller: _addNewLabelController, label: "Add New Label")),
            const SizedBox(width: 16),
            Flexible(child: AppInputText(controller: _addNewValueController, label: "Add New Value")),
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

  final Color _oddItemColor = const Color(0xFFF1F2F4);
  final Color _evenItemColor = const Color(0xFFF8F9FB);
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
            padding: EdgeInsets.zero,
              child: Container(
                width: 192,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.dark_1,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Text( _isTemplate ? "Save Template" : "Save Site Profile", style: TextStyles.bodyL.copyWith(color: Colors.white),),
              ),
              onPressed: _save),
          const SizedBox(width: 8),
          CupertinoButton(
              padding: EdgeInsets.zero,
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

  void _save() async {
    CTSiteProfile profile = CTSiteProfile(name: _profileNameController.text, customerId: widget.customerId);
    Map<String, dynamic> profiles = {};
    for (int i = 0; i < _profileItemLabelControllers.length; i++) {
      String label = _profileItemLabelControllers[i].text;
      if (label.isEmpty) continue;
      profiles[label] = _profileItemValueControllers[i].text.isEmpty ? null : _profileItemValueControllers[i].text;
    }
    profile.profiles = profiles;
    setState(() {
      // _siteProfiles.add(profile);
      _expandedList.add(ExpandState.collapsed);
      _isAdding = false;
      _isEditing = false;
    });
    NavigationController().loading();
    try {
      Map<String, dynamic> data = profile.toJson();
      print('data: $data');
      dynamic response = await Backendless.data
          .of(widget.isTemplate
              ? BLPath.siteProfileTemplate
              : BLPath.customerSiteProfile)
          .save(data);
      NavigationController().loading(isLoading: false);
      CTSiteProfile ctProfile = CTSiteProfile.fromMap(response as Map);

      if (widget.isTemplate) {
        List<CTSiteProfile>list = [..._siteProfiles, ctProfile];
        _baseController.siteProfileTemplates.value = list;
        WarningMessageDialog.showDialog(context, "Saved site Template!");
      } else {
        List<CTSiteProfile>list = [..._siteProfiles, ctProfile];
        CustomerModel model = widget.customerBloc.customerModelById(widget.customerId!)!;
        model.siteProfiles = list;
        widget.customerBloc.add(UpdateCustomerModelEvent(model));
        WarningMessageDialog.showDialog(context, "Saved site profiles!");
      }
      NavigationController().pop(context, delay: 2);
    } catch(e) {
      print('save data error: ${e.toString()}');
    }

  }

  void _gotIt() {
    setState(() {
      _isAdding = true;
      if (_isTemplate) {
        _isEditing = true;
      }
    });
  }
}
