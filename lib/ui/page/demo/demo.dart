// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:louzero/common/app_simple_dropdown.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/page/job/views/widget/contact_card.dart';
import 'package:louzero/ui/widget/time_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'Demo Components',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            _calendar(),
            _basicTabs(),
            _tabsExample(),
            _segmentControls(),
            _timePicker(context),
            _addNote(),
            _appConfirmDialog(),
            _contactCard(),
            _contactInfoLine(),
            _buttonStyles(),
            _formTextInput(),
            _loadingSpinner(),
            const SizedBox(
              height: 148,
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicTabs() {
    return _rowDark(
        child: AppTabsBasic(
          tabs: const ['Login', 'Sign Up'],
          children: [
            _dummyForm(label: 'Login'),
            _dummyForm(label: 'Sign Up'),
          ],
        ),
        label: 'Tabs for Login');
  }

  Widget _tabsExample() {
    const _icon = Icon(MdiIcons.star, size: 90, color: Colors.white);
    return _rowLight(
        child: AppCardTabs(
            mt: 0,
            mb: 16,
            mx: 24,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.blue,
                child: _icon,
              ),
              Container(
                height: 400,
                width: double.infinity,
                color: Colors.amber,
                child: _icon,
              ),
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.purple,
                child: _icon,
              )
            ],
            length: 3,
            tabNames: const ['One', 'Two', 'Three']),
        label: 'Card Tabs');
  }

  Widget _buttonStyles() {
    return AppCard(
      children: [
        _heading("Button Styles"),
        const SizedBox(
          height: 8,
        ),
        Text(
            'Buttons accesed via static functions -> Buttons.flat("label"), Buttons.submit("label"). These are all fixed styles with minimal props for use.',
            style: AppStyles.labelRegular.copyWith(height: 1.4)),
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
        const Text("With Icons", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            Buttons.submit('Submit', icon: Icons.save),
            Buttons.primary('Primary', icon: Icons.star),
            Buttons.outline('Outline', icon: MdiIcons.accountCircle),
            Buttons.menu('Menu', icon: Icons.settings),
            Buttons.flat('Flat', icon: Icons.chevron_right),
          ],
        ),
        const SizedBox(height: 24),
        const Text("With Icons & Expanded", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: [
            Buttons.submit('Submit', icon: Icons.save, expanded: true),
            Buttons.primary('Primary', icon: Icons.star, expanded: true),
            Buttons.outline('Outline',
                icon: MdiIcons.accountCircle, expanded: true),
            Buttons.menu('Menu', icon: Icons.settings, expanded: true),
            Buttons.flat('Flat', icon: Icons.chevron_right, expanded: true),
          ],
        ),
        const SizedBox(height: 24),
        const Text("With Popup Action Menu", style: AppStyles.headerRegular),
        const SizedBox(height: 24),
        AppPopMenu(
          button: [Buttons.outline('Quick Action Menu', icon: Icons.settings)],
          items: const [
            PopMenuItem(label: 'Action One', icon: Icons.settings),
            PopMenuItem(
                label: 'Action Two', icon: Icons.location_city_outlined),
            PopMenuItem(
                label: 'Action Three', icon: Icons.mail_outline_rounded),
          ],
        )
      ],
    );
  }

  Widget _contactInfoLine() {
    return AppCard(
      children: [
        _heading("Contact Info Line"),
        const SizedBox(height: 24),
        const AppContactInfoLine(
            label: "Phone",
            text: '745-876-9876',
            hint: 'Add your phone',
            icon: Icons.phone),
        const AppContactInfoLine(
            label: "Email",
            text: 'jacksparrow@skullisland.com',
            hint: 'Add your email',
            icon: Icons.mail),
        const AppContactInfoLine(
          label: "Service Address",
          text: '123 Alphabet Street, Suite 400, Portland OR 97202',
          hint: 'Add your email',
          icon: Icons.location_pin,
        ),
        const AppContactInfoLine(
          label: "Super Power",
          text: '',
          hint: 'Add your Super Power',
          icon: MdiIcons.lightningBolt,
        )
      ],
    );
  }

  Widget _addNote() {
    return _rowLight(
        label: 'Add Note Widget',
        child: const AppAddNote(
          initialText: "Simple quick note widget.",
        ));
  }

  Widget _appConfirmDialog() {
    return _rowLight(
        label: 'Confirm Dialog Widget',
        child: Buttons.outline(
          'Open Dialog',
          onPressed: () {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AppDialog(
                  title: 'App Dialog',
                  body: const AppTextBody('App Dialog'),
                  okayLabel: 'Got it',
                  onTapOkay: () {},
                );
              },
            );
          },
        ));
  }

  Widget _formTextInput() {
    return AppCard(children: [
      _heading('Form Inputs'),
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
      const SizedBox(
        height: 16,
      ),
      const AppTextField(
        label: 'Multi Line',
        multiline: true,
        initialValue:
            'Chambray glossier, paleo pitchfork deep v vape biodiesel sustainable waistcoat ugh. Distillery neutra palo santo pop-up offal chillwave copper mug tilde leggings air plant cardigan kinfolk fanny pack. Hashtag mixtape butcher irony. Lomo schlitz franzen cold-pressed jean shorts.',
      ),
      const SizedBox(height: 16),
      const AppMultiSelect(
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
      const SizedBox(height: 24),
      FlexRow(
        flex: const [3, 1, 2],
        children: [
          Container(),
          Buttons.text('Cancel', expanded: true),
          Buttons.primary('Update Account', expanded: true),
        ],
      ),
      AppSimpleDropDown(
          label: 'Duration',
          onSelected: (value) {
            print('valued $value');
          },
          items: const ['biodiesel sustainable', 'Two', 'Three'],
          dividerPosition: const [1])
    ]);
  }

  Widget _demoCenterCard(String label, {Widget? child}) {
    return AppCard(children: [
      _heading(label),
      Container(
        color: AppColors.secondary_99,
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

  Widget _loadingSpinner() => AppCard(pb: 48, children: [
        _heading("Loading Spinner"),
        const SizedBox(height: 24),
        const AppSpinner(),
      ]);

  Widget _segmentControls() => _rowDark(
      label: 'Segmented Control',
      child: AppSegmentedControl(
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
          print(value);
        },
      ));

  Widget _calendar() => _rowLight(
      label: 'Calendar',
      child: NZCalendar(
        onDateSelected: (value) {
          print('date has been changed $value');
        },
      ));

  Widget _timePicker(context) {
    return _rowLight(
      label: 'Time Picker',
      child: Buttons.outline('Open Time Picker', onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return NZTimePicker(
              onChange: (time) {
                print('the time is $time');
              },
            );
          },
        );
      }),
    );
  }

// DEMO LAYOUT UTILS
  Widget _rowDark(
      {required Widget child,
      required String label,
      double inset = 24,
      Color textColor = AppColors.white,
      Color color = AppColors.secondary_20}) {
    return Container(
        color: color,
        // margin: const EdgeInsets.only(top: 24, bottom: 24),
        padding:
            EdgeInsets.only(top: 24, bottom: 64, left: inset, right: inset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(),
                style: AppStyles.headerRegular
                    .copyWith(color: textColor, fontSize: 24)),
            AppDivider(
              color: textColor,
              mt: 8,
              size: 1,
            ),
            const SizedBox(height: 24),
            child,
          ],
        ));
  }

  Widget _rowLight({required Widget child, required String label}) {
    return _rowDark(
      child: child,
      label: label,
      textColor: AppColors.secondary_30,
      color: AppColors.white,
    );
  }

  Widget _dummyForm({label = "Login"}) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 64, right: 64),
      child: Column(
        children: [
          const AppTextField(
            label: 'Email',
          ),
          const AppTextField(
            label: 'Password',
          ),
          const SizedBox(height: 16),
          FlexRow(
            flex: const [2, 2],
            children: [
              Buttons.primary(label, expanded: true),
              const SizedBox(),
            ],
          )
        ],
      ),
    );
  }

  Widget _heading(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: AppStyles.headerRegular.copyWith(
                color: AppColors.secondary_30,
                fontSize: 24,
                letterSpacing: .5)),
        const AppDivider(mt: 16, mb: 24)
      ],
    );
  }
}
