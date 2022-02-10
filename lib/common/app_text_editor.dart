import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextEditor extends StatefulWidget {
  const AppTextEditor({
    required this.onChange,
    this.text,
    Key? key
  }) : super(key: key);
  final Function onChange;
  final String? text;

  @override
  _AppTextEditorState createState() => _AppTextEditorState();
}

class _AppTextEditorState extends State<AppTextEditor> {
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (!kIsWeb) {
              controller.clearFocus();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  shouldEnsureVisible: true,
                  initialText: widget.text ?? "",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  separatorWidget: const SizedBox(),
                  defaultToolbarButtons: [
                    const StyleButtons(),
                    const FontButtons(
                        clearAll: false,
                        subscript: false,
                        strikethrough: false
                    ),
                    const ParagraphButtons(
                      increaseIndent: false,
                      decreaseIndent: false,
                      lineHeight: false,
                      caseConverter: false,
                      textDirection: false,
                    ),
                    const ListButtons(listStyles: false),
                    const ColorButtons(foregroundColor: false),
                    const InsertButtons(
                        picture: false,
                        hr: false,
                        otherFile: false,
                        table: false,
                        video: false,
                        audio: false
                    ),
                  ],
                  toolbarPosition: ToolbarPosition.aboveEditor, //by default
                  toolbarType: ToolbarType.nativeScrollable, //by default
                  onButtonPressed: (ButtonType type, bool? status,
                      Function()? updateStatus) {
                    return true;
                  },
                  onDropdownChanged: (DropdownType type, dynamic changed,
                      Function(dynamic)? updateSelectedItem) {
                    return true;
                  },
                  mediaLinkInsertInterceptor:
                      (String url, InsertFileType type) {
                    return true;
                  },

                ),
                otherOptions: OtherOptions(
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.medium_2),
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
                callbacks: Callbacks(
                  onInit: () {
                    controller.editorController?.evaluateJavascript(
                      source:
                      'var head = document.head || document.getElementsByTagName("head")[0];var style = document.createElement("style");style.type = "text/css";var css = ".note-editable { background-color : red; }";style.appendChild(document.createTextNode(css));head.appendChild(style);',
                    );
                  },
                  onChangeContent: (String? changed) {
                    widget.onChange(changed);
                  },
                )
            ),
          ),
        ),
        Positioned(
          top: 55,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: AppColors.medium_2
            )
        )
      ],
    );
  }
}
