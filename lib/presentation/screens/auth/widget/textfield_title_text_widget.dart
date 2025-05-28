import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class TextfieldTitleTextWidget extends StatelessWidget {
  final String title;
  final bool isMandatory;
  const TextfieldTitleTextWidget({super.key, required this.title, this.isMandatory = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title.capitalizeFirst(),
          style: TextStyle(
            color: AppColor.primary.withValues(alpha: .75),
            fontWeight: FontWeight.w500,
            fontSize: width*0.04
          ),
          textAlign: TextAlign.start,
        ),

        if(isMandatory)
        Text(
          " *",
          style: TextStyle(
            color: AppColor.red,
            fontWeight: FontWeight.w500,
            fontSize: width*0.04
          ),
          textAlign: TextAlign.start,
        ),
        
      ],
    );
  }
}