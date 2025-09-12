import 'package:construction_technect/app/core/utils/imports.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.color,
    this.borderColor,
    this.fontColor,
    this.onTap,
    this.isLoading = false,
    this.fontSize,
    this.alignment,
    this.child,
    required this.buttonName,
    this.width,
    this.textAlign,
    this.height,
    this.borderRadius,
    this.verticalPadding,
    this.gradientColor,
    this.style,
    this.horizontalPadding,
  });

  final Color? color;
  final Color? borderColor;
  final Color? fontColor;
  final void Function()? onTap;
  final String buttonName;
  final double? fontSize;
  final TextAlign? textAlign;
  final Alignment? alignment;
  final Widget? child;
  final bool? isLoading;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final List<Color>? gradientColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 60,
        decoration: BoxDecoration(
          color: color ?? MyColors.primary,
          border:
              borderColor != null
                  ? Border.all(color: borderColor ?? MyColors.white)
                  : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
        ),
        alignment: alignment ?? Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 16,
          horizontal: horizontalPadding ?? 0,
        ),
        child:
            (child == null)
                ? isLoading == true
                    ? const CircularProgressIndicator()
                    : Text(
                      buttonName,
                      textAlign: textAlign,
                      style:
                          style ??
                          MyTexts.medium16.copyWith(
                            color: fontColor ?? MyColors.white,
                            fontSize: fontSize ?? 18.sp,
                          ),
                    )
                : child,
      ),
    );
  }
}
