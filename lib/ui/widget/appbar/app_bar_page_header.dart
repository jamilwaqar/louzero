import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppBarPageHeader extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final String leadingTxt;
  final bool hasActions;
  final BuildContext context;
  final VoidCallback? onMenuPress;
  final List<Widget>? footerStart;
  final List<Widget>? footerEnd;

  const AppBarPageHeader(
      {required this.title,
      required this.context,
      this.actions,
      this.leading,
      this.leadingTxt = '',
      this.hasActions = true,
      this.onMenuPress,
      this.footerStart,
      this.footerEnd,
      Key? key})
      : super(key: key);

  @override
  Size get preferredSize => footerEnd != null || footerStart != null
      ? const Size.fromHeight(192)
      : const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        shadowColor: Colors.transparent,
        // backgroundColor: AppColors.appBar,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF465D66), Color(0xFF182933)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        title: title,
        centerTitle: true,
        actions: actions,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child:
              Wrap(runAlignment: WrapAlignment.center, spacing: 8, children: [
            if (Navigator.canPop(context))
              AppActionButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icons.arrow_back),
            AppActionButton(
                onPressed: onMenuPress ?? () {}, icon: MdiIcons.text),
          ]),
        ),
        bottom: AppBarFooter(
          footerEnd: footerEnd ?? [],
          footerStart: footerStart ?? [],
        ));
  }
}

class AppActionButton extends StatelessWidget {
  const AppActionButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 45,
      height: 45,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        elevation: 0,
        child: Icon(icon, color: Colors.white),
        color: Colors.white.withAlpha(30),
        // mini: true,
        // backgroundColor: Colors.white.withAlpha(30),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}

class AppBarFooter extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? footerStart;
  final List<Widget>? footerEnd;

  const AppBarFooter({Key? key, this.footerStart, this.footerEnd})
      : super(key: key);

  @override
  _AppBarFooterState createState() => _AppBarFooterState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _AppBarFooterState extends State<AppBarFooter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 32, right: 32),
          child: Row(children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: widget.footerStart ?? [],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.footerEnd ?? [],
                  )
                ],
              ),
            )
          ]),
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.secondary_99,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ))
          ],
        )
      ],
    );
  }
}
