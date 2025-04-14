import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';

enum CallType { incoming, outgoing, missed }

class CallLogTile extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final CallType callType;

  const CallLogTile({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.callType,
  });

  @override
  Widget build(BuildContext context) {
    String iconPath;
    Color iconColor;

    switch (callType) {
      case CallType.incoming:
        iconPath = AssetsConstant.incomingIcon;
        iconColor = AppColor.green;
        break;
      case CallType.outgoing:
        iconPath = AssetsConstant.outgoingIcon;
        iconColor = AppColor.blue;
        break;
      case CallType.missed:
        iconPath = AssetsConstant.missedCallIcon;
        iconColor = AppColor.red;
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Image.asset(iconPath, width: AppDimens.icon20, height: AppDimens.icon20, color: iconColor),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppDimens.textSize16,
          color: callType == CallType.missed ? AppColor.red : AppColor.primary,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.grey, fontSize: AppDimens.textSize14), 
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: AppDimens.textSize14), 
          ),
        ],
      ),
    );
  }
}
