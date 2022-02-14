import 'package:flutter/cupertino.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_empty_graphics.dart';
import 'package:louzero/common/app_getting_started.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';

class CheckListPage extends StatelessWidget{
  const CheckListPage({Key? key}) : super(key: key);
  final _description = "Create checklists to provide a quick way to select services performed while on the job. This also builds value around your business from the customer's point of view and bonus, you can auto-charge for these services.";


  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      child: _body(),
      subheader: "Service Checklists",
    );
  }

  Widget  _body() {
    return Column(
      children: [
        const SizedBox(height: 24,),
        AppCard(
          children: [
            AppGettingStarted(
                description: _description,
                onCheckboxPress: (value) {

                },
                onGotItPress: () {

                }
            ),
            const SizedBox(height: 24,),
            const AppEmptyGraphics(
                title: "Empty State Illustration",
                description: "You haven’t created any service checklists yet"
            ),
            const SizedBox(height: 24,),
            Center(
              child:  AppAddButton("Add Checklist", onPressed: (){}),
            ),
            const SizedBox(height: 24,),
          ],
        )
      ],
    );
  }

  Widget _createChecklist() {
    //TODO
    return const Text('_createChecklist');
  }

  Widget _checklistItems() {
    //TODO
    return const Text('_checklistItems');
  }

  Widget _addChecklistItem() {
    //TODO
    return const Text('_addChecklistItem');
  }

  Widget _editChecklistItem() {
    //TODO
    return const Text('_editChecklistItem');
  }

  Widget _checklistCard() {
    //TODO
    return const Text('_checklistCard');
  }

}