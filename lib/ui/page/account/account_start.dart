import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/common/app_step_progress.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/common/app_text_header.dart';
import 'package:louzero/ui/page/base_scaffold.dart';

class AccountStart extends StatefulWidget {
  const AccountStart({Key? key}) : super(key: key);

  @override
  _AccountStartState createState() => _AccountStartState();
}

class _AccountStartState extends State<AccountStart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _controlTBD = TextEditingController();
    return BaseScaffold(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  const AppTextHeader(
                    "To start, let’s get some basic info.",
                    mt: 32,
                    mb: 58,
                  ),
                  const AppTextBody(
                    'You can always make changes later in Settings',
                    mb: 32,
                  ),
                  AppStepProgress()
                ],
              )),
          Expanded(
            flex: 3,
            child: PageView(children: [
              _CompanyDetails(controlTBD: _controlTBD),
              _CompanyDetails(controlTBD: _controlTBD),
              _CompanyDetails(controlTBD: _controlTBD),
            ]),
          )
        ],
      ),
    );
  }
}

class _CompanyDetails extends StatelessWidget {
  const _CompanyDetails({
    Key? key,
    required TextEditingController controlTBD,
  })  : _controlTBD = controlTBD,
        super(key: key);

  final TextEditingController _controlTBD;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppCard(
            mt: 32,
            children: [
              const AppTextHeader(
                "Company Details",
                alignLeft: true,
                icon: Icons.people,
                size: 24,
              ),
              AppFlexRow(
                children: [
                  AppFlexColumn(children: [
                    AppInputText(
                        controller: _controlTBD, label: 'Company Name'),
                    AppInputText(controller: _controlTBD, label: 'Website'),
                  ]),
                  AppFlexColumn(ml: 16, children: [
                    AppInputText(
                        controller: _controlTBD, label: 'Phone Number'),
                    AppInputText(
                        controller: _controlTBD, label: 'Email Address')
                  ])
                ],
              ),
              AppInputText(
                  controller: _controlTBD,
                  label: 'What Industries do you serve?'),
            ],
          ),
          AppCard(mt: 24, children: [
            const AppTextHeader(
              "Company Address",
              alignLeft: true,
              icon: Icons.location_on,
              size: 24,
            ),
            AppInputText(controller: _controlTBD, label: 'Country'),
            AppInputText(controller: _controlTBD, label: 'Street Address'),
            AppInputText(controller: _controlTBD, label: 'Apt / Suite / Other'),
            AppFlexRow(
              children: [
                AppFlexColumn(flex: 2, children: [
                  AppInputText(controller: _controlTBD, label: 'City'),
                ]),
                AppFlexColumn(ml: 16, children: [
                  AppInputText(controller: _controlTBD, label: 'State'),
                ]),
                AppFlexColumn(ml: 16, children: [
                  AppInputText(controller: _controlTBD, label: 'Zip'),
                ]),
              ],
            )
          ]),
        ],
      ),
    );
  }
}

class AppFlexRow extends StatelessWidget {
  const AppFlexRow({
    Key? key,
    required this.children,
    this.mt = 0,
    this.mb = 0,
  }) : super(key: key);

  final List<Widget> children;
  final double mt;
  final double mb;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class AppFlexColumn extends StatelessWidget {
  const AppFlexColumn({
    Key? key,
    required this.children,
    this.ml = 0,
    this.mr = 0,
    this.flex = 1,
  }) : super(key: key);

  final List<Widget> children;
  final double ml;
  final double mr;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.only(left: ml, right: mr),
        child: Column(
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}
