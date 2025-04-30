import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    required this.focusNode,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.spacing50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha:0.4),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColor.greenishGrey.withValues(alpha:0.4),
            offset: const Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        enabled: enabled,
        cursorColor: AppColor.primary,
        cursorWidth: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.primary.withValues(alpha:0.7),
            fontWeight: FontWeight.w400,
            fontSize: AppDimens.textSize16,
          ),
        ),
        style: TextStyle(color: AppColor.primary, fontSize: AppDimens.textSize16),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
        onTapOutside: (event) => focusNode.unfocus(),
      ),
    );
  }
}
