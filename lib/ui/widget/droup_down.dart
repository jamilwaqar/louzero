import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class NZDropDownMenu extends StatelessWidget {
  final String label;

  const NZDropDownMenu({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButtonFormField<int>(
          isExpanded: true,
          hint: Text(label),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0.0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              isDense: true),
          value: null,
          items: [
            DropdownMenuItem<int>(
              value: 0,
              child: Container(
                width: 100,
                height: 50,
                child: const Text(
                  "less character", style: TextStyles.text16
                ),
              ),
            ),
            DropdownMenuItem<int>(
                value: 1,
                child: Container(
                  width: 100,
                  height: 50,
                  child: const Text(
                    "mooooorrrrreeee character", style: TextStyles.text16,
                  ),
                )),
          ],
      ),
    );
  }
}
