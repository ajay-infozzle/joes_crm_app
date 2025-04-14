import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class CustomButton extends StatelessWidget {
  
  final double buttonHeight;
  final double buttonWidth;
  final String text;
  final VoidCallback onPressed;
  final bool isActive;
  final bool hasBorder;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
    this.hasBorder = false,
    this.borderRadius = AppDimens.buttonRadius12,
    this.backgroundColor,
    this.textColor,
    this.fontSize = AppDimens.textSize16,
    this.fontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    this.borderWidth = AppDimens.buttonBorderWidth,
    this.buttonHeight = AppDimens.buttonHeight,
    this.buttonWidth = AppDimens.buttonwidth
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? (backgroundColor ?? AppColor.primary)
              : AppColor.greenishGrey.withValues(alpha:0.5),
          foregroundColor: textColor ?? Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: hasBorder
                ? BorderSide(color: AppColor.primary, width: borderWidth)
                : BorderSide.none,
          ),
          elevation: isActive ? 0 : 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: isActive ? textColor ?? AppColor.white : AppColor.primary,
          ),
        ),
      ),
    );
  }
}
