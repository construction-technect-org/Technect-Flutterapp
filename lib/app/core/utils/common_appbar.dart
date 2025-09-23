import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final bool automaticallyImplyLeading;
  final bool isImageOrNot = true;
  final TextStyle? textStyle;
  final bool deleteIcon;
  final bool? isCenter;
  final bool showFilterIcon;
  final double? leadingWidth;
  final Callback? onTap;
  final Function()? onTapAction;
  final Callback? reloadOnTap;

  CommonAppBar({
    super.key,
    this.title,
    this.onTap,
    this.isCenter,
    this.leading,
    this.action,
    this.backgroundColor,
    this.leadingWidth,
    this.reloadOnTap,
    this.showFilterIcon = true,
    this.automaticallyImplyLeading = true,
    this.onTapAction,
    this.deleteIcon = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions:action,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? 40,
      leading: automaticallyImplyLeading
          ? leading ??
              GestureDetector(
                onTap: onTap ??
                    () {
                      Get.back();
                    },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios, color: MyColors.black),
                ),
              )
          : Container(),
      backgroundColor: backgroundColor?? MyColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: MyColors.black, size: 24),
      centerTitle: isCenter??true,
      titleTextStyle: textStyle ??  MyTexts.medium18.copyWith(color: Colors.black,fontFamily: MyTexts.Roboto),
      title: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

}
