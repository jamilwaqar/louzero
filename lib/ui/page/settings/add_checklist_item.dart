import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_advanced_textfield.dart';
import 'package:louzero/common/app_drop_down.dart';
import 'package:louzero/common/app_textfield.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/job/job_add_new_line.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddChecklistItem extends StatefulWidget{
  const AddChecklistItem({Key? key}) : super(key: key);

  @override
  _AddChecklistItemState createState() => _AddChecklistItemState();

}

class _AddChecklistItemState extends State<AddChecklistItem>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _chargeController = TextEditingController();
  String _durationType = "";
  String _itemType = "";
  bool isRecommended = false;
  bool includeCharge = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.secondary_95,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16,),
          const Align(
              alignment: Alignment.centerLeft,
              child:  const Text('Add Checklist Item', style: AppStyles.headerRegular),
          ),

          const SizedBox(height: 16,),
          AppAdvancedTextField(
            label: 'Name (eg. Check gauges) *',
            controller: _nameController,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 16,),
          AppSwitch(
            value: isRecommended,
            label: 'Recommended Schedule',
            onChanged: (value) {
              setState(() {
                isRecommended = value;
              });
            },
          ),
          isRecommended
              ?
          _recommendedSchedule()
              :
          const SizedBox(),
          const SizedBox(height: 16,),
          AppSwitch(
            value: includeCharge,
            label: 'Include a charge for this item',
            onChanged: (value) {
              setState(() {
                includeCharge = value;
              });
            },
          ),
          const SizedBox(height: 16,),
          includeCharge
              ?
              _includeCharge()
              :
          const SizedBox(),
          const SizedBox(height: 32,),
          const Align(
            alignment: Alignment.centerLeft,
            child: AppButton(label: 'Add to checklist', icon: MdiIcons.plusCircle, colorIcon: AppColors.orange,)
          ),

        ],
      ),
    );
  }

  Widget _recommendedSchedule() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Every', style: AppStyles.labelRegular),
          const SizedBox(width: 16,),
          SizedBox(
            width: 150,
            child: TextField(
              controller: _durationController,
            ),
          ),
          const SizedBox(width: 16,),
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: AppColors.secondary_99,
              borderRadius: BorderRadius.circular(5),
            ),
            child: AppDropDown(
              itemList: const ["Days", "Hours", "Minutes"],
              initValue: _durationType.isNotEmpty ? _durationType : "Days",
              onChanged: (value) {
                setState(() {
                  _durationType = value!;
                });
              },
            ),
          )

        ],
      ),
    );
  }

  Widget _includeCharge() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: const Text('Assign an Inventory Item', style: AppStyles.labelBold,),
          ),
          const SizedBox(height: 16,),
          FlexRow(
            flex: const [2, 1, 1],
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary_99,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AppDropDown(
                  itemList: const ["Item from the inventory"],
                  initValue: _itemType.isNotEmpty ? _itemType : "Item from the inventory",
                  onChanged: (value) {
                    setState(() {
                      _itemType = value!;
                    });
                  },
                ),
              ),
              AppTextField(
                label: 'Charge',
                controller: _chargeController,
              ),
              AppTextField(
                label: 'Unit',
                controller: _unitController,
              ),
            ],
          ),
          const SizedBox(height: 16,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Inventory item price at time of service will be used and the item description will be added to the job bill.', style: AppStyles.labelRegular.copyWith(fontSize: 12),),
          ),

        ],
      ),
    );
  }

}