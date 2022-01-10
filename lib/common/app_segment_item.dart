import 'package:flutter/cupertino.dart';

class AppSegmentItem extends StatelessWidget{
  const AppSegmentItem({
    Key? key,
    required this.icon,
    required this.text
  }) : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
       Icon(icon),
       const SizedBox(width: 5),
       Text(text)
     ],
   );
  }

}