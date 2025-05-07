import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback onTap;
  const RetryWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Something Went wrong",
            style: TextStyle(color: AppColor.primary),
          ),
          15.h,

          CustomButton(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
            ),
            text: "Retry",
            onPressed: onTap,
            borderRadius: AppDimens.radius16,
            isActive: true,
            buttonHeight: AppDimens.buttonHeight35,
            fontSize: AppDimens.textSize16,
          ),
        ],
      )
    );
  }
}