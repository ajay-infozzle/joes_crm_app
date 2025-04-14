import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class TextfieldTitleTextWidget extends StatelessWidget {
  final String title;
  const TextfieldTitleTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Text(
        title.capitalizeFirst(),
        style: TextStyle(
          color: AppColor.primary.withValues(alpha: .75),
          fontWeight: FontWeight.w500,
          fontSize: width*0.04
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}