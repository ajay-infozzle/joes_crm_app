import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/data/model/email_camp_list_model.dart';


class EmailCampaignTile extends StatelessWidget {
  final Emailcampaigns campgn;
  const EmailCampaignTile({super.key, required this.campgn});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.spacing12),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8, horizontal: AppDimens.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text("ID : ${sales.id}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                //     AppDimens.spacing8.w,
          
                //     const Text("|", style: TextStyle(color: Colors.grey)),
          
                //     AppDimens.spacing8.w,
                //     Text("Store : ${getStore(context, sales.storeId!)}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                //   ],
                // ),
                Text("${campgn.title}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                5.h,

                Text(
                  "Status : ${campgn.status}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                Text(
                  "Creation date : ${campgn.creationDate}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                Text(
                  "Creation by : ${getUser(context, campgn.createdBy??'')}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

              ],
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                // context.pushNamed(
                //   RoutesName.singleEmailCampaignScreen,
                //   extra: campgn.id
                // );
              },
              child: Container(
                width: AppDimens.buttonHeight30,
                height: AppDimens.buttonHeight30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: .1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimens.spacing12),
                    bottomLeft: Radius.circular(AppDimens.spacing12)
                  )
                ),
                child: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: AppDimens.spacing18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}