import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/decoration.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/utils.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: NavigationController().notifierInitLoading,
      builder: (ctx, value, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.dark_1,
                body: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64,
                        child: Icon(
                          Icons.workspaces_outline,
                          color: AppColors.lightest,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: Utils().screenSize(context).width,
                          decoration: BoxDecorationEx.shadowEffect(
                              onlyTop: true,
                              borderRadius: 32,
                              backgroundColor: AppColors.light_1
                          ),
                          child: widget.child,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (value)
              Positioned.fill(
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.dark_3.withOpacity(0.6),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.lightest,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset('assets/double_ring_loading_io.gif',),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
