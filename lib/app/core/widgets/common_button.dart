import 'package:construction_technect/app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final String? imageAsset; // image path
  final double width;
  final double height;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double textSize;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final Color? imageColor; // new parameter for image tint
  final TextStyle? textStyle; // ✅ added

  const CommonButton({
    super.key,
    this.text,
    this.icon,
    this.imageAsset,
    required this.onPressed,
    this.width = 100,
    this.height = 40,
    this.backgroundColor = MyColors.primary,
    this.borderRadius = 20,
    this.textSize = 14,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.iconSize = 20,
    this.imageColor,
    this.textStyle, // ✅ init
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: iconColor, size: iconSize),
            if (imageAsset != null)
              Image.asset(
                imageAsset!,
                width: iconSize,
                height: iconSize,
                color: imageColor,
              ),
            if (text != null)
              Padding(
                padding: EdgeInsets.only(
                  left: (icon != null || imageAsset != null) ? 8 : 0,
                ),
                child: Text(
                  text!,
                  style: textStyle ??
                      TextStyle(fontSize: textSize, color: textColor), // ✅
                ),
              ),
          ],
        ),
      ),
    );
  }
}
