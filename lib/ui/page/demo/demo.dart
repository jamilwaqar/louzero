import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_multiselect.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class demo extends StatelessWidget {
  demo({Key? key}) : super(key: key);

  List<SelectItem> selectItems = [
    SelectItem(id: '1', value: '', label: 'One'),
    SelectItem(id: '2', value: '', label: 'Two'),
    SelectItem(id: '3', value: '', label: 'Three'),
    SelectItem(id: '4', value: '', label: 'Four'),
    SelectItem(id: '5', value: '', label: 'Five'),
  ];

  List<Widget> tabItems = [
    Container(
      color: AppColors.lightest,
      child: Icon(Icons.airplane_ticket, size: 150, color: AppColors.orange),
    ),
    Container(
      color: AppColors.lightest,
      child: Icon(Icons.location_pin, size: 150, color: AppColors.orange),
    ),
    Container(
      color: AppColors.lightest,
      child: Icon(Icons.loupe_sharp, size: 150, color: AppColors.orange),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppCardTabs(
              length: 3,
              tabNames: ['One', 'Schedule', 'Billing'],
              children: tabItems,
            ),
            _multiSelect(),
            _buttonsAndMenus(),
          ],
        ),
      ),
    );
  }

  Widget _heading(String text,
      [icon = Icons.chevron_right, double px = 0, double py = 0]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: py),
      child: AppTextHeader(
        text,
        alignLeft: true,
        icon: icon,
        size: 24,
      ),
    );
  }

  Widget _multiSelect() => AppCard(mt: 24, children: [
        _heading('MultiSelect Widget', Icons.list),
        AppMultiSelect(
          items: selectItems,
        ),
        AppInputRow(
          flex: [2, 1, 1],
          children: [
            AppInputText(label: 'Name', mb: 0, mt: 24),
            AppInputText(label: 'Phone', mb: 0, mt: 24),
            AppInputText(label: 'Email', mb: 0, mt: 24)
          ],
        ),
        Row(
          children: [
            Expanded(
              child: AppInputText(label: 'Name', mb: 0, mt: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppInputText(label: 'Phone', mb: 0, mt: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppInputText(label: 'Phone', mb: 0, mt: 24),
            )
          ],
        )
      ]);

  Widget _buttonsAndMenus() => AppCard(mt: 24, children: [
        _heading('Buttons and Menus', Icons.control_point_rounded),
        Row(
          children: const [
            Expanded(
              child: AppButton(
                label: 'Primary',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 0,
              child: AppPopMenu(
                button: [
                  Icon(Icons.control_point_rounded,
                      size: 40, color: AppColors.orange)
                ],
                items: [
                  PopMenuItem(label: 'Action One', icon: Icons.settings),
                  PopMenuItem(
                      label: 'Action Two', icon: Icons.location_city_outlined),
                  PopMenuItem(
                      label: 'Action Three', icon: Icons.mail_outline_rounded),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AppButton(
                label: 'Secondary',
                primary: false,
              ),
            ),
          ],
        )
      ]);
}

class AppInputRow extends StatelessWidget {
  AppInputRow(
      {Key? key, this.children = const <Widget>[], this.flex = const <int>[]})
      : super(key: key);

  final List<int> flex;
  final List<Widget> children;
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < children.length; i++) {
      int _flex = flex.asMap().containsKey(i) ? flex[i] : 1;

      items.add(Expanded(flex: _flex, child: children[i]));
      if (i < children.length - 1) {
        items.add(const SizedBox(width: 16));
      }
    }

    return Row(
      children: items.toList(),
    );
  }
}

class AppCardTabs extends StatelessWidget {
  const AppCardTabs(
      {Key? key,
      required this.children,
      required this.length,
      required this.tabNames,
      this.uppercase = true})
      : super(key: key);

  final bool uppercase;
  final int length;
  final List<Widget> children;
  final List<String> tabNames;

  Tab _tab(String text) {
    String _label = uppercase ? text.toUpperCase() : text;
    return Tab(
      child: Text(
        _label,
        style: GoogleFonts.barlowCondensed(
            fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(mt: 24, pl: 0, pr: 0, pt: 0, pb: 0, children: [
      DefaultTabController(
        length: 3,
        child: Container(
          height: 400,
          child: Column(
            children: [
              DecoratedBox(
                // color: AppColors.secondary_99,
                decoration: BoxDecoration(
                  color: AppColors.secondary_99.withOpacity(0.5),
                  border: const Border(
                      bottom:
                          BorderSide(color: AppColors.secondary_90, width: 2)),
                ),
                child: TabBar(
                  labelColor: AppColors.secondary_30,
                  indicatorColor: AppColors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  tabs: tabNames.map((name) {
                    return _tab(name);
                  }).toList(),
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: children,
              ))
            ],
          ),
        ),
      )
    ]);
  }
}
