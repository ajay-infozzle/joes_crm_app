import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';


class ActivityListWidget extends StatelessWidget {
  final List<ActivityStream>? activityList ;
  const ActivityListWidget({super.key, required this.activityList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activityList!.map((item) {
        final dateTime = formatDateTime(item.date??'');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.user ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.textSize14,
                      color: AppColor.primary
                    ),
                  ),
                  Text(
                    dateTime['time']??'',
                    style: TextStyle(
                      fontSize: AppDimens.textSize12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              4.h,

              Text(
                item.action ?? '',
                style: TextStyle(
                  fontSize: AppDimens.textSize14,
                  color: AppColor.primary
                ),
              ),
              5.h,

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  dateTime['date'] ?? '',
                  style: TextStyle(
                    fontSize: AppDimens.textSize12,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
            ],
          ),
        );
      }).toList(),
    );
  }
}