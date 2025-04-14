import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
// import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String profileImage;

  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          // leading: CircleAvatar(
          //   radius: AppDimens.radius20,
          //   backgroundColor: AppColor.greenishGrey,
          //   // backgroundImage: profileImage.isEmpty ? AssetImage(profileImage) : NetworkImage(profileImage),
          //   backgroundImage: profileImage.isEmpty ? AssetImage(AssetsConstant.personIcon) : NetworkImage(profileImage),
          // ),
          leading: CircleAvatar(
            radius: AppDimens.radius20,
            backgroundColor: AppColor.greenishGrey,
            child: Text(
              name.split('').first, 
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontSize: AppDimens.textSize16 ,fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            lastMessage,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: AppDimens.textSize14 ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: AppDimens.textSize12, color: Colors.grey),
              ),
              if (unreadCount > 0)
                Container(
                  margin: const EdgeInsets.only(top: AppDimens.spacing4),
                  padding: const EdgeInsets.all(AppDimens.spacing6),
                  decoration: const BoxDecoration(
                    color: AppColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      fontSize: AppDimens.textSize12,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
