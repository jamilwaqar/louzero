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

  Tab _tab(String text) {
    return Tab(
      child: Text(
        text,
        style: GoogleFonts.barlowCondensed(
            fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppCard(mt: 24, pl: 0, pr: 0, pt: 0, pb: 0, children: [
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
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.secondary_90, width: 2)),
                          ),
                          child: TabBar(
                            labelColor: AppColors.secondary_30,
                            indicatorColor: AppColors.orange,
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            tabs: [
                              _tab('JOB DETAILS'),
                              _tab('SCHEDULE'),
                              _tab('BILLING'),
                            ],
                          ),
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [
                            Container(
                              color: AppColors.lightest,
                              child: Icon(Icons.airplane_ticket,
                                  size: 150, color: AppColors.orange),
                            ),
                            Container(
                              color: AppColors.lightest,
                              child: Icon(Icons.location_pin,
                                  size: 150, color: AppColors.orange),
                            ),
                            Container(
                              color: AppColors.lightest,
                              child: Icon(Icons.loupe_sharp,
                                  size: 150, color: AppColors.orange),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ))
            ]),
            AppCard(mt: 24, children: [
              AppTextHeader(
                'MultiSelect Widget',
                alignLeft: true,
                icon: Icons.list,
                size: 24,
              ),
              AppMultiSelect(
                items: selectItems,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppInputText(label: 'Name', mb: 0, mt: 24),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppInputText(label: 'Phone', mb: 0, mt: 24),
                  )
                ],
              )
            ]),
            AppCard(mt: 24, children: [
              AppTextHeader(
                'Buttons and Menus',
                alignLeft: true,
                icon: Icons.list,
                size: 24,
              ),
              Row(
                children: const [
                  Expanded(
                    child: AppButton(
                      label: 'Primary',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      label: 'Secondary',
                      primary: false,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 0,
                    child: AppPopMenu(
                      button: [
                        AppButton(label: 'Secondary', color: Colors.blueAccent)
                      ],
                      items: [
                        PopMenuItem(label: 'Action One', icon: Icons.settings),
                        PopMenuItem(
                            label: 'Action Two',
                            icon: Icons.location_city_outlined),
                        PopMenuItem(
                            label: 'Action Three',
                            icon: Icons.mail_outline_rounded),
                      ],
                    ),
                  )
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
