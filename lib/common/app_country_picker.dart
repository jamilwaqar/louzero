import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/countries.dart';

// MultiSelect Widget
class AppCountryPicker extends StatefulWidget {
  final String label = 'Select Country';
  final double width = 400;
  final void Function(List<CountryCode>)? onChange;

  const AppCountryPicker({
    Key? key,
    this.onChange,
  }) : super(key: key);

  @override
  State<AppCountryPicker> createState() => _AppCountryPickerState();
}

class _AppCountryPickerState extends State<AppCountryPicker> {
  final List<CountryCode> selectedItems = [];
  final List<CountryCode> codes = CountryCodes.list;

  Future<void> openDialog() async {
    return showDialog<void>(
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
      children: [_selectButton()],
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
                  )
                ],
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              horizontalTitleGap: 0,
              tileColor: AppColors.secondary_99,
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

    if (widget.onChange != null) {
      widget.onChange!(selectedItems);
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
            child: Text(item.name, style: AppStyles.labelRegular),
          ),
          onTap: () => onSelectItem(item),
        ),
        // const AppDivider(mb: 0, mt: 0, color: AppColors.light_1)
      ],
    );
  }
}
