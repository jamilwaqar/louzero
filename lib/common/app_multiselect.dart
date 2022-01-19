import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_text_body.dart';
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
  final List<SelectItem> items;
  final List<SelectItem> initialItems;
  final String label;
  final double width;
  final bool showLabel;
  final void Function(List<SelectItem>)? onChange;

  const AppMultiSelect({
    Key? key,
    this.items = const [],
    this.initialItems = const [],
    this.label = 'Select Options',
    this.width = 300,
    this.showLabel = true,
    this.onChange,
  }) : super(key: key);

  @override
  State<AppMultiSelect> createState() => _AppMultiSelectState();
}

class _AppMultiSelectState extends State<AppMultiSelect> {
  List<SelectItem> selectedItems = [];

  late List<SelectItem> items;

  @override
  void initState() {
    super.initState();
    items = widget.items.isNotEmpty ? widget.items : [];
    if (widget.initialItems.isNotEmpty) {
      selectedItems = widget.initialItems;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> openDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label, style: AppStyles.headerDialog),
              const AppDivider(color: AppColors.secondary_90, mt: 16, mb: 0)
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...items.map((item) {
                      return SelectTile(
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
        key: const Key('done'),
        margin: const EdgeInsets.all(16),
        wide: true,
        label: "Done",
        primary: true,
        colorBg: AppColors.orange,
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
      key: const Key('select'),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedItems.isNotEmpty && widget.showLabel)
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
                          return SelectChip(
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
              trailing: const Icon(Icons.arrow_drop_down),
              horizontalTitleGap: 0,
              tileColor: AppColors.lightest,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.light_3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              onTap: () {
                openDialog();
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

class SelectChip extends StatelessWidget {
  final VoidCallback? onDeleted;
  final String label;

  const SelectChip({Key? key, this.onDeleted, this.label = 'Sample'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.secondary_99,
      shape:
          const StadiumBorder(side: BorderSide(color: AppColors.secondary_70)),
      labelPadding: const EdgeInsets.only(left: 14, right: 14),
      label: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.dark_3)),
      deleteIconColor: AppColors.medium_2,
      deleteIcon: const Icon(
        Icons.close,
        size: 20,
        color: AppColors.secondary_40,
      ),
      onDeleted: onDeleted ?? () {},
    );
  }
}

class SelectTile extends StatelessWidget {
  final SelectItem item;
  final bool isSelected;
  final ValueChanged<SelectItem> onSelectItem;
  final IconData? iconSelected;
  final IconData? iconUnselected;

  const SelectTile({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onSelectItem,
    this.iconSelected = Icons.check_box_sharp,
    this.iconUnselected = Icons.check_box_outline_blank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding:
              const EdgeInsets.only(left: 32, right: 32, top: 0, bottom: 0),
          leading: Icon(
            isSelected ? iconSelected : iconUnselected,
            color: isSelected ? AppColors.primary_60 : AppColors.dark_1,
          ),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Text(item.label, style: AppStyles.labelRegular),
          ),
          onTap: () => onSelectItem(item),
        ),
        // const AppDivider(mb: 0, mt: 0, color: AppColors.light_1)
      ],
    );
  }
}
