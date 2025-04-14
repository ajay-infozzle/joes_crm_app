import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class EmailListItemWidget extends StatelessWidget {
  final Map<String, dynamic> email;
  final VoidCallback ontap;

  const EmailListItemWidget({super.key, required this.email, required this.ontap});

  @override
  Widget build(BuildContext context) {
    bool isUnread = email['isUnread'] ?? false; 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: ontap,
        child: Row(
          children: [
            //~ Profile Icon
            CircleAvatar(
              backgroundColor: AppColor.greenishGrey,
              child: Text(
                email['sender'][0], 
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        
            12.w,
        
            //~ Email Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email['sender'] ?? '',
                    style: const TextStyle(
                      fontSize: AppDimens.textSize15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        
                  4.h,
                  
                  Text(
                    email['subject'] ?? '',
                    style: TextStyle(
                      fontSize: AppDimens.textSize13,
                      fontWeight: isUnread ? FontWeight.w700 : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
        
                  2.h,
        
                  Text(
                    email['message'] ?? '',
                    style: TextStyle(
                      fontSize: AppDimens.textSize12,
                      fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            10.w,
        
            //~ Date + Star Icon
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  email['date'] ?? '',
                  style: const TextStyle(
                    fontSize: AppDimens.textSize11,
                    color: Colors.grey,
                  ),
                ),
        
                8.h,
        
                Icon(
                  Icons.star,
                  color: email['isImportant'] == true ? AppColor.primary : Colors.transparent,
                  size: AppDimens.textSize18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
