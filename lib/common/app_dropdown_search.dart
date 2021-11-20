import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppDropdownSearch extends StatefulWidget {
  final String label;
  final Color colorBg;
  final Color colorBd;
  final Color colorTx;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final double mt;
  final double mb;
  final bool autofocus;

  const AppDropdownSearch(
      {Key? key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.colorTx = AppColors.dark_3,
      this.colorBd = AppColors.light_3,
      this.colorBg = AppColors.lightest,
      this.mt = 0,
      this.mb = 16})
      : super(key: key);
  @override
  State createState() {
    return AppDropdownSearchState();
  }
}

class AppDropdownSearchState extends State<AppDropdownSearch> {
  //TODO: Mpve temp data to property
  List<String> items = <String>[
    "1234 Street St. Vancouver, WA 98607",
    "4282 Sunrise St. Vancouver, WA 98607",
    "811155 Desktop Dr. Vancouver, WA 98622",
    "1st St. Vancouver, WA 98607",
    "2nd Sunrise Ct. Vancouver, WA 98607",
    "1223 Laptop Rd. Vancouver, WA 98622",
  ];
  TextEditingController controller = TextEditingController();
  String filter = "";
  late Offset textFieldPosition;
  late Size widgetSize;
  bool isDrowdownListShown = false;
  OverlayEntry? dropdownListOverlayContainer;

  @override
  void initState() {
    super.initState();
    initTextEditingControllerListeners();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inputContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: widget.colorBg,
      border: Border.all(
        color: widget.colorBd,
        width: 1,
      ),
    );

    var inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: widget.colorTx,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: widget.mt,
        ),
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.dark_2,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              decoration: inputContainer,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 1,
                  left: 16.0,
                  right: 16.0,
                  bottom: 1,
                ),
                child: TextField(
                  onTap: () {
                    showDrowdownList();
                  },
                  onEditingComplete: () {
                    closeDrowdownList();
                  },
                  style: inputText,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    suffixIcon: Visibility(
                      visible: controller.text.isNotEmpty,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ),
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        if (filter == "") {
          return _buildRow(items[index]);
        } else {
          if (items[index].toLowerCase().contains(filter.toLowerCase())) {
            return _buildRow(items[index]);
          } else {
            return Container();
          }
        }
      },
    );
  }

  Widget _buildRow(String rowText) {
    return Material(
      child: GestureDetector(
        onTap: () {
          _selectChoice(rowText);
        },
        child: ListTile(
          tileColor: widget.colorBg,
          leading: const Icon(Icons.pin_drop_sharp),
          title: Text(
            rowText,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: 'Roboto',
              color: AppColors.dark_1,
            ),
          ),
        ),
      ),
    );
  }

  void initTextEditingControllerListeners() {
    controller.addListener(() {
      if (controller.text.isEmpty) {
        closeDrowdownList();
      }

      setState(() {
        filter = controller.text;
      });
    });
  }

  void _selectChoice(String choice) {
    setState(() {
      controller.text = choice;
    });
    closeDrowdownList();
  }

  void onTextInput() {
    if (isDrowdownListShown) {
      closeDrowdownList();
    }
  }

  void closeDrowdownList() {
    setState(() {
      dropdownListOverlayContainer?.remove();
      dropdownListOverlayContainer = null;
      isDrowdownListShown = false;
    });
  }

  void showDrowdownList() {
    if (isDrowdownListShown) {
      return;
    }
    var overlayEntry = _openMenu();
    setState(() {
      dropdownListOverlayContainer = overlayEntry;
    });
    Overlay.of(context)!.insert(dropdownListOverlayContainer!);

    isDrowdownListShown = true;
  }

  OverlayEntry _openMenu() {
    final popupButtonObject = context.findRenderObject() as RenderBox;
    Offset offset = popupButtonObject.localToGlobal(Offset.zero);
    const double padding = 10;
    var yPosition = offset.dy + popupButtonObject.size.height - padding;

    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Positioned(
          top: yPosition,
          left: offset.dx,
          child: Container(
            padding: const EdgeInsets.only(bottom: padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.colorBg,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            width: popupButtonObject.size.width,
            child: _buildListView(),
          ),
        );
      },
    );
  }
}
