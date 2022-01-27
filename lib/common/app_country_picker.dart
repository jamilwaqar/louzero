import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/countries.dart';
import 'package:flag/flag.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:collection/collection.dart';

// MultiSelect Widget
class AppCountryPicker extends StatefulWidget {
  final String label = 'Select Country';
  final double width = 400;
  final String? defaultCountryCode;
  final void Function(String)? onChange;

  const AppCountryPicker({
    Key? key,
    this.onChange,
    this.defaultCountryCode,
  }) : super(key: key);

  @override
  State<AppCountryPicker> createState() => _AppCountryPickerState();
}

class _AppCountryPickerState extends State<AppCountryPicker> {
  final List<CountryCode> selectedItems = [];
  final List<CountryCode> codes = CountryCodes.shortList;

  @override
  initState() {
    super.initState();

    if (widget.defaultCountryCode != null) {
      CountryCode? _selected = codes.firstWhereOrNull((el) =>
          el.code.toLowerCase() == widget.defaultCountryCode!.toLowerCase());

      if (_selected != null) {
        selectedItems.add(_selected);
      }
    }
  }

  Future<void> openDialog() async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
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
                    ...codes.map((item) {
                      dynamic _flag;
                      if (Flag.flagsCode.contains(item.code.toLowerCase())) {
                        _flag = Flag.fromString(
                          item.code.toLowerCase(),
                          fit: BoxFit.cover,
                          flagSize: FlagSize.size_1x1,
                          borderRadius: 1,
                          width: 32,
                          height: 32,
                        );
                      }

                      return SelectTile(
                        isSelected: selectedItems.contains(item),
                        item: item,
                        iconFlag: Container(
                          width: 32,
                          height: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: _flag,
                          ),
                        ),
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
                    _button(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Buttons.primary(
        'Done',
        onPressed: () {
          Navigator.of(context).pop();
        },
        expanded: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectButton(),
        if (selectedItems.isNotEmpty) AppDivider(mt: 0, mb: 0),
      ],
    );
  }

  Widget _selectButton() => MaterialButton(
      key: const Key('select'),
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                              label: item.name,
                              onDeleted: () {
                                onRemoveItem(item);
                              });
                        }).toList(),
                      if (selectedItems.isEmpty)
                        Text(widget.label,
                            style: AppStyles.labelBold.copyWith(
                                height: 1,
                                fontSize: 16,
                                color: AppColors.secondary_40))
                    ],
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              horizontalTitleGap: 0,
              tileColor: selectedItems.isNotEmpty
                  ? Colors.transparent
                  : AppColors.secondary_99,
              shape: RoundedRectangleBorder(
                // side: const BorderSide(color: AppColors.light_3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              onTap: () {
                openDialog();
              }),
        ],
      ),
      onPressed: () {});

  void onSelectItem(CountryCode item) {
    if (selectedItems.contains(item)) {
      setState(() {
        selectedItems.remove(item);
      });
    } else {
      setState(() {
        selectedItems.clear();
        selectedItems.add(item);
      });
    }
  }

  void onRemoveItem(CountryCode item) {
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
    return Text(label,
        style: AppStyles.labelBold.copyWith(
          height: 1,
          fontSize: 16,
          color: AppColors.secondary_40,
        ));
  }
}

class SelectTile extends StatelessWidget {
  final CountryCode item;
  final bool isSelected;
  final ValueChanged<CountryCode> onSelectItem;
  final IconData? iconSelected;
  final IconData? iconUnselected;
  final Widget? iconFlag;
  final bool selected;

  const SelectTile({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onSelectItem,
    this.selected = false,
    this.iconFlag,
    this.iconSelected = Icons.check_box_sharp,
    this.iconUnselected = Icons.check_box_outline_blank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          tileColor: isSelected ? AppColors.secondary_99 : Colors.transparent,
          contentPadding:
              const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
          trailing: isSelected
              ? Icon(MdiIcons.checkBold, color: AppColors.primary_1)
              : null,
          leading: iconFlag ??
              Icon(
                isSelected ? iconSelected : iconUnselected,
                color: isSelected ? AppColors.primary_60 : AppColors.dark_1,
              ),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Text(item.name,
                style: AppStyles.labelBold.copyWith(fontSize: 16)),
          ),
          onTap: () => onSelectItem(item),
        ),
        // const AppDivider(mb: 0, mt: 0, color: AppColors.light_1)
      ],
    );
  }
}
