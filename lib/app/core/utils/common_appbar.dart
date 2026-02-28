import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final TextStyle? textStyle;
  final bool? isCenter;
  final double? leadingWidth;
  final Callback? onTap;
  final Function()? onTapAction;
  final Callback? reloadOnTap;

  const CommonAppBar({
    super.key,
    this.title,
    this.onTap,
    this.isCenter,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.leadingWidth,
    this.reloadOnTap,
    this.automaticallyImplyLeading = true,
    this.onTapAction,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? 40,
      leading: automaticallyImplyLeading
          ? leading ??
                GestureDetector(
                  onTap:
                      onTap ??
                      () {
                        Get.back();
                      },
                  behavior: HitTestBehavior.translucent,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black, size: 24),
                  ),
                )
          : Container(),
      backgroundColor: backgroundColor ?? MyColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: MyColors.black, size: 24),
      centerTitle: isCenter ?? true,
      titleTextStyle: textStyle ?? MyTexts.medium18.copyWith(color: MyColors.gray2E),
      title: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
