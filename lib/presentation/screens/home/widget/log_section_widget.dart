import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class LogSectionWidget extends StatelessWidget {
  final String title;
  final List<String> assetIcon;
  final List<String> names;
  final VoidCallback? onTap;

  const LogSectionWidget({
    super.key,
    required this.title,
    required this.assetIcon,
    required this.names,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: width*0.06, horizontal: width*0.05),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: .4),
        borderRadius: BorderRadius.circular(AppDimens.radius14)
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.greenishGrey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.radius14))
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: 0),
              tileColor: AppColor.greenishGrey,
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: AppDimens.icon18),
              onTap: onTap,
            ),
          ),
          Column(
            children: names.asMap().entries.map((entry) {
              int index = entry.key;
              String name = entry.value;

              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: 0),
                leading: Image.asset(assetIcon[index], width: AppDimens.icon20, height: AppDimens.icon20),
                title: Text(name),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
