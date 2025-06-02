import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class TemplEditableTextContainer extends StatelessWidget {
  final TextEditingController controller;

  const TemplEditableTextContainer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.spacing10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.primary,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius10),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        style: TextStyle(
          fontSize: AppDimens.textSize14,
          color: AppColor.primary,
        ),
        decoration: const InputDecoration.collapsed(
          hintText: "Enter template...",
        ),
        cursorColor: AppColor.primary,
        onTapUpOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
