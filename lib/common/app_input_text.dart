import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

import 'app_text_body.dart';

class AppInputText extends StatefulWidget {
  const AppInputText(
      {Key? key,
      required this.label,
      this.controller,
      this.onSaved,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.onChanged,
      this.password = false,
      this.autofocus = false,
      this.required = false,
      this.colorTx = AppColors.dark_3,
      this.colorBd = AppColors.light_3,
      this.colorBg = AppColors.lightest,
      this.height = 48,
      this.mt = 0,
      this.mb = 16,
      this.options})
      : super(key: key);

  final String label;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Color colorBg;
  final Color colorBd;
  final Color colorTx;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final bool password;
  final bool required;
  final double mt;
  final double mb;
  final bool autofocus;
  final double height;
  final void Function(String)? onChanged;
  final List<String>? options;

  @override
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    var reqText = widget.required ? '*' : '';
    var inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: widget.colorTx,
    );

    //Input border props:
    double _radius = 4;
    double _width = 1;
    Color _color = AppColors.light_3;
    Color _focus = AppColors.darkest;

    InputDecoration inputStyle = InputDecoration(
      filled: true,
      fillColor: AppColors.lightest,
      contentPadding:
          const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: _color, width: _width),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: _focus, width: _width),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: _color, width: _width),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_radius),
        borderSide: BorderSide(color: _focus, width: _width),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextBody(widget.label + reqText,
            size: 14,
            color: AppColors.dark_2,
            bold: true,
            mb: 8,
            mt: widget.mt),
        TextFormField(
          autofocus: widget.autofocus,
          controller: widget.controller,
          keyboardAppearance: Brightness.light,
          keyboardType: widget.keyboardType,
          obscureText: widget.password,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          style: inputText,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          decoration: inputStyle,
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }
}

  



// Save: autocomplete option (in progress)
//_autoCompleteInput(List<String> options) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return options.where((String option) {
//           var opt = option.toLowerCase().trim().replaceAll(' ', '');
//           var val = textEditingValue.text.toLowerCase().trim()
//             ..replaceAll(' ', '');
//           return opt.startsWith(val);
//         });
//       },
//       optionsViewBuilder: (context, onSelected, options) => Align(
//         alignment: Alignment.topLeft,
//         child: Material(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//           elevation: 4,
//           child: Container(
//             decoration: BoxDecoration(
//                 color: AppColors.lightest,
//                 border: Border.all(color: AppColors.light_2, width: 1),
//                 borderRadius: BorderRadius.circular(8)),
//             child: Padding(
//               padding: EdgeInsetsDirectional.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: options
//                     .map((e) => GestureDetector(
//                           onTap: () => onSelected(e),
//                           child: Container(
//                             constraints:
//                                 BoxConstraints.loose(const Size.fromWidth(250)),
//                             alignment: Alignment.centerLeft,
//                             height: 30,
//                             child: Text(
//                               e,
//                               style: appTextBodyStyle(
//                                 bold: true,
//                                 color: AppColors.medium_3,
//                               ),
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController fieldTextEditingController,
//           FocusNode fieldFocusNode,
//           VoidCallback onFieldSubmitted) {
//         return Column(
//           children: [
//             TextField(
//               style: const TextStyle(color: AppColors.darkest),
//               decoration: inputStyle,
//               controller: fieldTextEditingController,
//               focusNode: fieldFocusNode,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }