import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Demo extends StatelessWidget {
  Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'Demo Components',
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
            child: AppCardTabs(
              height: 500,
              length: 3,
              tabNames: const ['Overview', 'Schedule', 'Billing'],
              children: tabItems,
            ),
          ),
          _loadingSpinner(),
          _multiSelect(),
          _formInputs(),
          _buttonsAndMenus(),
        ],
      ),
    );
  }

  // MOCK DATA (MULTISELECT)
  List<SelectItem> selectItems = const [
    SelectItem(id: '1', value: '', label: 'Cheese'),
    SelectItem(id: '2', value: '', label: 'Mushrooms'),
    SelectItem(id: '3', value: '', label: 'Jalepenos'),
    SelectItem(id: '4', value: '', label: 'Tomatos'),
    SelectItem(id: '4', value: '', label: 'Peperoni'),
    SelectItem(id: '4', value: '', label: 'Cookie Dough'),
    SelectItem(id: '4', value: '', label: 'Sausage'),
    SelectItem(id: '5', value: '', label: 'Onions'),
    SelectItem(id: '5', value: '', label: 'Garlic'),
    SelectItem(id: '5', value: '', label: 'Gravel'),
  ];

  // MOCK DATA (TABS)
  final List<Widget> tabItems = [
    AppTabPanel(
      children: [
        const AppTextHeader('Basic Info',
            alignLeft: true, icon: Icons.airplane_ticket, size: 24),
        AppFlexRow(
          flex: const [2, 2],
          children: const [
            AppInputText(
              label: 'First',
              initial: 'Brad',
            ),
            AppInputText(
              label: 'Last',
              initial: 'Smith',
            ),
            AppInputText(
              label: 'Alias',
              initial: 'The Closer',
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        AppFlexRow(
          flex: const [2],
          children: [
            Column(
              children: const [
                AppTextBody(
                  'What if you want to call it from a stateless widget? Well, that’s possible too. Use a stateful widget as a your root widget that you can provide a callback function too to execute your startup logic. See example below.',
                  bold: true,
                  mb: 16,
                ),
                AppTextBody(
                  'What if you want to call it from a stateless widget? Well, that’s possible too. Use a stateful widget as a your root widget that you can provide a callback function too to execute your startup logic. See example below.',
                )
              ],
            ),
            const AppTextBody(
              'What if you want to call it from a stateless widget? Well, that’s possible too. Use a stateful widget as a your root widget that you can provide a callback function too to execute your startup logic. See example below.',
              pl: 8,
            ),
          ],
        )
      ],
    ),
    AppTabPanel(
      children: [Icon(Icons.location_pin, size: 150, color: AppColors.orange)],
    ),
    AppTabPanel(
      children: [
        const Icon(Icons.loupe_sharp, size: 150, color: AppColors.orange)
      ],
    ),
  ];

  // RENDER FUNCTIONS
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

  Widget _loadingSpinner() => AppCard(pb: 48, children: [
        _heading('Loading Spinner', MdiIcons.pirate),
        const AppSpinner(),
      ]);

  Widget _multiSelect() => AppCard(children: [
        _heading('MultiSelect Widget', Icons.list),
        AppMultiSelect(
          items: selectItems,
        ),
      ]);

  Widget _formInputs() => AppCard(children: [
        _heading('Form Inputs', Icons.forum_rounded),
        AppFlexRow(
          children: const [
            AppInputText(label: 'First'),
            AppInputText(label: 'Last'),
            AppInputText(label: 'Nickname'),
          ],
        ),
        AppFlexRow(
          flex: const [4, 1],
          children: const [
            AppInputText(label: 'Address'),
            AppInputText(label: 'Suite'),
          ],
        ),
        AppFlexRow(
          children: [
            const AppInputText(label: 'Country'),
            AppMultiSelect(
              label: 'Toppings',
              items: selectItems,
            )
          ],
        ),
        AppFlexRow(
          flex: const [2, 3],
          children: const [
            AppInputText(label: 'Alias'),
            AppInputText(label: 'Planet of Origin'),
          ],
        ),
        AppFlexRow(
          flex: const [3],
          children: [
            Container(),
            const AppButton(
                label: 'Cancel', primary: false, color: AppColors.secondary_60),
            const AppButton(label: 'Submit', color: AppColors.orange),
          ],
        )
      ]);

  Widget _buttonsAndMenus() => AppCard(children: [
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
