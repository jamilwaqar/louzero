import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Demo extends StatelessWidget {
  Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'Demo Components',
      child: Column(
        children: [
          const SizedBox(height: 32),
          _buttonStyles(),
          _contactInfoLine(),
          _segmentControls(),
          _formTextInput(),
          _addNote(),
          _numberStepper(),
          _contactCard(),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
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
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }

  // MOCK DATA (TABS)
  final List<Widget> tabItems = [
    AppTabPanel(
      children: [
        const AppTextHeader('Basic Info',
            alignLeft: true, icon: Icons.airplane_ticket, size: 24),
        FlexRow(
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
        FlexRow(
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
    const AppTabPanel(
      children: [Icon(Icons.location_pin, size: 150, color: AppColors.orange)],
    ),
    const AppTabPanel(
      children: [Icon(Icons.loupe_sharp, size: 150, color: AppColors.orange)],
    ),
  ];

  Widget _buttonStyles() {
    return AppCard(
      children: [
        Text("Button Styles Default", style: AppStyles.headerRegular),
        SizedBox(
          height: 8,
        ),
        Text(
            'Buttons accesed via static functions -> Buttons.flat("label"), Buttons.submit("label"). These are all fixed styles with minimal props for use.',
            style: AppStyles.labelRegular.copyWith(height: 1.4)),
        SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            Buttons.submit('Submit'),
            Buttons.primary('Primary'),
            Buttons.outline('Outline'),
            Buttons.menu('Menu'),
            Buttons.flat('Flat'),
            Buttons.text('Text'),
          ],
        ),
        SizedBox(height: 24),
        Text("With Icons", style: AppStyles.headerRegular),
        SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            Buttons.submit('Submit', icon: Icons.save),
            Buttons.primary('Primary', icon: Icons.favorite),
            Buttons.outline('Outline', icon: MdiIcons.accountCircle),
            Buttons.menu('Menu', icon: Icons.settings),
            Buttons.flat('Flat', icon: Icons.chevron_right),
          ],
        ),
        SizedBox(height: 24),
        Text("With Icons & Expanded", style: AppStyles.headerRegular),
        SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            Buttons.submit('Submit', icon: Icons.save, expanded: true),
            Buttons.primary('Primary', icon: Icons.favorite, expanded: true),
            Buttons.outline('Outline',
                icon: MdiIcons.accountCircle, expanded: true),
            Buttons.menu('Menu', icon: Icons.settings, expanded: true),
            Buttons.flat('Flat', icon: Icons.chevron_right, expanded: true),
          ],
        )
      ],
    );
  }

  Widget _contactInfoLine() {
    return const AppCard(
      children: [
        Text("Contact Info Line", style: AppStyles.headerRegular),
        SizedBox(height: 24),
        AppContactInfoLine(
            label: "Phone",
            text: '745-876-9876',
            hint: 'Add your phone',
            icon: Icons.phone),
        AppContactInfoLine(
            label: "Email",
            text: 'jacksparrow@skullisland.com',
            hint: 'Add your email',
            icon: Icons.mail),
        AppContactInfoLine(
          label: "Service Address",
          text: '123 Alphabet Street, Suite 400, Portland OR 97202',
          hint: 'Add your email',
          icon: Icons.location_pin,
        ),
        AppContactInfoLine(
          label: "Super Power",
          text: '',
          hint: 'Add your Super Power',
          icon: MdiIcons.lightningBolt,
        )
      ],
    );
  }

  Widget _addNote() {
    return _demoCenterCard('Add Note Widget',
        child: const AppAddNote(
          initialText: "Simple quick note widget.",
        ));
  }

  Widget _formTextInput() {
    return AppCard(children: [
      const Text('TextField', style: AppStyles.headerRegular),
      const SizedBox(
        height: 24,
      ),
      FlexRow(
        children: const [
          AppTextField(
            label: 'First Name',
            initialValue: 'Tennessee',
          ),
          AppTextField(label: 'Last Name')
        ],
      ),
      SizedBox(
        height: 16,
      ),
      AppTextField(
        label: 'Multi Line',
        multiline: true,
        initialValue:
            'Chambray glossier, paleo pitchfork deep v vape biodiesel sustainable waistcoat ugh. Distillery neutra palo santo pop-up offal chillwave copper mug tilde leggings air plant cardigan kinfolk fanny pack. Hashtag mixtape butcher irony. Lomo schlitz franzen cold-pressed jean shorts.',
      )
    ]);
  }

  Widget _demoCenterCard(String label, {Widget? child}) {
    return AppCard(children: [
      Text(
        label,
        style: AppStyles.headerRegular,
      ),
      const SizedBox(height: 24),
      Container(
        color: const Color(0xFFF6F2EC),
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Container(
            color: const Color(0xFFFFFFFF),
            width: 400,
            child: child,
            padding: const EdgeInsets.all(16),
          ),
        ),
      )
    ]);
  }

  Widget _numberStepper() {
    return const AppCard(children: [
      Text(
        'Number Stepper',
        style: AppStyles.headerRegular,
      ),
      SizedBox(height: 24),
      AppNumberStepper()
    ]);
  }

  Widget _contactCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 0),
      child: ContactCard(
        title: 'Contact Card Demo',
        contact: CustomerContact(
            firstName: 'Joe',
            lastName: 'Somebody',
            email: 'joe@somesite.com',
            phone: '(510) 843-4356',
            role: 'Owner'),
        address: AddressModel(
            country: 'US',
            street: '123 Alphabet Street',
            city: 'Portland',
            state: 'OR',
            zip: '97202'),
      ),
    );
  }

  Widget _loadingSpinner() => const AppCard(pb: 48, children: [
        Text("Loading Spinner", style: AppStyles.headerRegular),
        SizedBox(height: 24),
        AppSpinner(),
      ]);

  Widget _multiSelect() => const AppCard(children: [
        Text("MultiSelect Widget", style: AppStyles.headerRegular),
        SizedBox(height: 24),
        AppMultiSelect(
          items: [
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
          ],
        ),
      ]);

  Widget _formInputs() => AppCard(children: [
        const Text("Form Inputs", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
        FlexRow(
          children: const [
            AppInputText(label: 'First'),
            AppInputText(label: 'Last'),
            AppInputText(label: 'Nickname'),
          ],
        ),
        FlexRow(
          flex: const [2, 3],
          children: const [
            AppInputText(label: 'Alias'),
            AppInputText(
              label: 'Home Planet',
            ),
          ],
        ),
        FlexRow(
          flex: const [3],
          children: [
            Container(),
            const AppButton(
                label: 'Cancel',
                primary: false,
                colorBg: AppColors.secondary_60),
            const AppButton(label: 'Submit', colorBg: AppColors.orange),
          ],
        )
      ]);

  Widget _buttonsAndMenus() => AppCard(children: [
        const Text("Buttons and Menus", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
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

  Widget _segmentControls() => AppCard(children: [
        const Text("Segmented Control", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
        AppSegmentedControl(
          fromMax: true,
          isStretch: true,
          children: const {
            1: AppSegmentItem(
              text: 'Estimate (99)',
              icon: MdiIcons.calculator,
            ),
            2: AppSegmentItem(
              text: 'Booked (97)',
              icon: MdiIcons.calendar,
            ),
            3: AppSegmentItem(
              text: 'Invoiced',
              icon: MdiIcons.currencyUsd,
            ),
            4: AppSegmentItem(
              text: 'Canceled',
              icon: MdiIcons.cancel,
            ),
          },
          onValueChanged: (int value) {
            // print(value);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        AppSegmentedToggle(
            itemList: const ["%", "\$"],
            onChange: (value) {
              //print('value has been changed $value');
            })
      ]);
}
