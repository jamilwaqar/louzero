import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'app_text_body.dart';

class AppInputText extends StatelessWidget {
  const AppInputText(
      {Key? key,
      required this.label,
      this.initial,
      this.hint,
      this.controller,
      this.onSaved,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.onChanged,
      this.password = false,
      this.autofocus = false,
      this.required = false,
      this.readOnly = false,
      this.labelHidden = false,
      this.labelRemoved = false,
      this.inputFormatters,
      this.colorTx = AppColors.dark_3,
      this.colorBd = AppColors.light_3,
      this.colorBdFocus = AppColors.dark_3,
      this.colorBg = AppColors.lightest,
      this.enabled = true,
      this.height = 48,
      this.mt = 0,
      this.mb = 16,
      this.options})
      : super(key: key);

  final String label;
  final String? hint;
  final String? initial;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Color colorBg;
  final Color colorBd;
  final Color colorBdFocus;
  final Color colorTx;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final bool password;
  final bool required;
  final bool readOnly;
  final bool labelHidden;
  final bool labelRemoved;
  final double mt;
  final double mb;
  final bool autofocus;
  final double height;
  final void Function(String)? onChanged;
  final List<String>? options;
  final bool enabled;
  //Input border props:
  final BorderRadius _radius = Common.border_4;
  final double _width = 1;

  @override
  Widget build(BuildContext context) {
    var reqText = required ? '*' : '';
    var inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: colorTx,
    );

    InputDecoration inputStyle = InputDecoration(
      filled: true,
      hintText: hint,
      fillColor: colorBg,
      contentPadding:
          const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 0),
      errorBorder: OutlineInputBorder(
        borderRadius: _radius,
        borderSide: BorderSide(color: colorBd, width: _width),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _radius,
        borderSide: BorderSide(color: colorBdFocus, width: _width),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _radius,
        borderSide: BorderSide(color: colorBd, width: _width),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: _radius,
        borderSide: BorderSide(color: colorBd, width: _width),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _radius,
        borderSide: BorderSide(color: colorBdFocus, width: _width),
      ),
    );

    return Column(
      // mainAxisSize: MainAxisSize.
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !labelRemoved,
          child: Opacity(
            opacity: labelHidden ? 0 : 1,
            child: AppTextBody(
              label + reqText,
              size: 14,
              color: AppColors.dark_2,
              bold: true,
              mb: 8,
              mt: mt,
            ),
          ),
        ),
        TextFormField(
          initialValue: initial,
          autofocus: autofocus,
          controller: controller,
          keyboardAppearance: Brightness.light,
          keyboardType: keyboardType,
          obscureText: password,
          onChanged: onChanged,
          onSaved: onSaved,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          validator: validator,
          style: inputText,
          enabled: enabled,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration: inputStyle,
        ),
        SizedBox(
          height: mb,
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