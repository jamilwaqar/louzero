import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'app_button.dart';

class AppAddNote extends StatefulWidget {
  final String initialText;
  final Function(String)? onChange;

  const AppAddNote({
    this.initialText = '',
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  State<AppAddNote> createState() => _AppAddNoteState();
}

class _AppAddNoteState extends State<AppAddNote> {
  bool visible = false;
  String currentText = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  initState() {
    super.initState();

    if (widget.initialText.isNotEmpty) {
      currentText = widget.initialText;
      _noteController.text = widget.initialText;
      visible = false;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !visible && currentText.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeaderIcon(
                  'Notes',
                  icon: Icons.edit,
                  onTap: () {
                    setState(() {
                      visible = true;
                    });
                  },
                ),
                Text(currentText,
                    style: AppStyles.labelRegular.copyWith(
                      height: 1.6,
                      color: AppColors.darkest,
                    ))
              ],
            ),
          ),
          Visibility(
            visible: !visible && currentText.isEmpty,
            child: AppButtons.iconFlat(
              'Add Note',
              icon: MdiIcons.note,
              onPressed: () {
                setState(() {
                  visible = true;
                });
              },
            ),
          ),
          Visibility(
              visible: visible,
              child: Column(
                children: [
                  AppInputMultiLine(
                    controller: _noteController,
                    // autofocus: currentText.isEmpty,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  RowSplit(
                    left: Row(
                      children: [
                        AppButton(
                            label: 'Save Note',
                            padX: 24,
                            onPressed: () {
                              print(_noteController.text);
                              setState(() {
                                currentText = _noteController.text;
                                visible = false;
                                if (widget.onChange != null) {
                                  widget.onChange!(_noteController.text);
                                }
                              });
                            }),
                        AppButton(
                          label: 'Cancel',
                          primary: false,
                          onPressed: () {
                            setState(() {
                              visible = false;
                            });
                          },
                        )
                      ],
                    ),
                    right: Row(
                      children: [
                        if (currentText.isNotEmpty)
                          AppButton(
                            colorIcon: AppColors.error_60,
                            colorText: AppColors.error_60,
                            colorBg: Colors.transparent,
                            icon: Icons.delete,
                            label: 'Delete Note',
                            onPressed: () {
                              setState(() {
                                _noteController.text = '';
                                currentText = '';
                                visible = false;
                                if (widget.onChange != null) {
                                  widget.onChange!(_noteController.text);
                                }
                              });
                            },
                          )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
