import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final Color confirmColor;
  final VoidCallback onConfirmed;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.confirmColor,
    required this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppDimens.textSize16,
          fontWeight: FontWeight.bold,
          color: AppColor.primary,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          fontSize: AppDimens.textSize14,
          color: AppColor.primary,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius16),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: AppDimens.textSize14,
              color: AppColor.primary,
            ),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        TextButton(
          child: Text(
            confirmText,
            style: TextStyle(
              fontSize: AppDimens.textSize14,
              color: confirmColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            onConfirmed();
            context.pop();
          },
        ),
      ],
    );
  }
}
