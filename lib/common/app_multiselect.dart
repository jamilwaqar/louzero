import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';

// SeletItem Model
class SelectItem {
  final String label;
  final String id;
  final String value;

  const SelectItem(
      {required this.label, required this.id, required this.value});
}

// MultiSelect Widget
class AppMultiSelect extends StatefulWidget {
  const AppMultiSelect({
    Key? key,
    this.items = const [],
    this.initialItems = const [],
    this.label = 'Select Options',
    this.width = 300,
    this.onChange,
  }) : super(key: key);
  final List<SelectItem> items;
  final List<SelectItem> initialItems;
  final String label;
  final double width;
  final void Function(List<SelectItem>)? onChange;

  @override
  State<AppMultiSelect> createState() => _AppMultiSelectState();
}

class _AppMultiSelectState extends State<AppMultiSelect> {
  List<SelectItem> selectedItems = [];

  late List<SelectItem> items;

  @override
  void initState() {
    items = widget.items.isNotEmpty ? widget.items : [];
    if (widget.initialItems.isNotEmpty) {
      selectedItems = widget.initialItems;
    }
  }

  Future<void> OpenDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int? selectedRadio = 0;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 16),
          title: AppTextBody(
            widget.label,
            size: 24,
            bold: true,
            center: true,
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...items.map((item) {
                      return SelectListTile(
                        isSelected: selectedItems.contains(item),
                        item: item,
                        onSelectItem: (item) {
                          setState(() {
                            onSelectItem(item);
                          });
                        },
                      );
                    }).toList(),
                    SizedBox(
                      width: widget.width,
                    ),
                    _doneButton(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _doneButton() => AppButton(
        mt: 16,
        ml: 16,
        mr: 16,
        mb: 16,
        wide: true,
        label: "Done",
        primary: true,
        color: AppColors.medium_3,
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_selectButton()],
    );
  }

  Widget _selectButton() => MaterialButton(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedItems.isNotEmpty)
            AppTextBody(widget.label,
                color: AppColors.dark_2, mb: 8, bold: true, size: 14),
          ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      if (selectedItems.isNotEmpty)
                        ...selectedItems.map((item) {
                          return _tag(
                              label: item.label,
                              onDeleted: () {
                                onRemoveItem(item);
                              });
                        }).toList(),
                      if (selectedItems.isEmpty)
                        AppTextBody(widget.label,
                            color: AppColors.dark_2,
                            mb: 0,
                            bold: true,
                            size: 14),
                    ],
                  )
                ],
              ),
              trailing: Icon(Icons.arrow_drop_down),
              horizontalTitleGap: 0,
              tileColor: AppColors.lightest,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.light_3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              onTap: () {
                OpenDialog();
              }),
        ],
      ),
      onPressed: () {});

  void onSelectItem(SelectItem item) {
    final isSelected = selectedItems.contains(item);
    setState(() {
      isSelected ? selectedItems.remove(item) : selectedItems.add(item);
    });
    if (widget.onChange != null) {
      widget.onChange!(selectedItems);
    }
  }

  void onRemoveItem(SelectItem item) {
    final isSelected = selectedItems.contains(item);
    if (isSelected) {
      setState(() => selectedItems.remove(item));
    }
  }
}

Widget _tag({label = 'chip', VoidCallback? onDeleted}) => Chip(
      backgroundColor: Colors.black12,
      labelPadding: EdgeInsets.only(left: 14, right: 14),
      label: Text(label,
          style:
              TextStyle(fontWeight: FontWeight.w600, color: AppColors.dark_3)),
      deleteIconColor: AppColors.medium_2,
      deleteIcon: const Icon(
        Icons.remove_circle,
        size: 20,
      ),
      onDeleted: onDeleted ?? () {},
    );

class SelectListTile extends StatelessWidget {
  final SelectItem item;
  final bool isSelected;
  final ValueChanged<SelectItem> onSelectItem;
  final IconData? iconSelected;
  final IconData? iconUnselected;

  const SelectListTile({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onSelectItem,
    this.iconSelected = Icons.check_circle,
    this.iconUnselected = Icons.add_circle_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _style = TextStyle(color: AppColors.darkest, fontSize: 18);
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.only(left: 32, right: 32, top: 0, bottom: 0),
          leading: Icon(
            isSelected ? iconSelected : iconUnselected,
            color: AppColors.dark_1,
          ),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Text(item.label, style: _style),
          ),
          onTap: () => onSelectItem(item),
        ),
        AppDivider(mb: 0, mt: 0, color: AppColors.light_1)
      ],
    );
  }
}
