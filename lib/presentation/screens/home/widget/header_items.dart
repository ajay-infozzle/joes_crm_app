import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class HeaderItemList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function(int index)? onTap;

  const HeaderItemList({
    super.key,
    required this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: SizedBox(
              width: AppDimens.spacing60,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.greenishGrey.withValues(alpha: .4),
                    // backgroundImage: AssetImage(item["icon"]!),
                    child: Image.asset(
                      item["icon"]!,
                      height: AppDimens.icon25,
                      width: AppDimens.icon25,
                    ),
                  ),
                  10.h,
                  Text(
                    item["title"] ?? "",
                    style: TextStyle(
                      fontSize: AppDimens.textSize10,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
