import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class RememberMeWidget extends StatelessWidget {
  final Function(bool?) onTap;
  final bool isChecked;
  const RememberMeWidget({super.key, required this.onTap, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Row(
        children: [
          Checkbox.adaptive(
            value: isChecked, 
            onChanged: onTap,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColor.primary,
          ),

          AppDimens.spacing10.w,

          Text(
            "Remember me",
            style: TextStyle(
              color: AppColor.primary.withValues(alpha: .75),
              fontWeight: FontWeight.w500,
              fontSize: width*0.04
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}