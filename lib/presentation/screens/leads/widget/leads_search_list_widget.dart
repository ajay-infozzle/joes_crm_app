import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';


class LeadsSearchListWidget extends StatelessWidget {
  final Leads leads ;
  const LeadsSearchListWidget({super.key, required this.leads});

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
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8,horizontal: AppDimens.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("ID : ${leads.id}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                    AppDimens.spacing8.w,
          
                    const Text("|", style: TextStyle(color: Colors.grey)),
          
                    AppDimens.spacing8.w,
                    Text("Store : ${leads.store}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                  ],
                ),
                5.h,
          
                Text(
                  "Name : ${leads.name} ${leads.surname}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                Text(
                  "Email : ${leads.email}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                Text(
                  "Amount : ${leads.amount}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),
          
                // 10.h,
          
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: CustomButton(
                //         padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                //         text: "View",
                //         onPressed: () {
                //           context.pushNamed(
                //             RoutesName.leadScreen,
                //             extra: leads.id
                //           );
                //         },
                //         borderRadius: AppDimens.radius10,
                //         isActive: true,
                //         buttonHeight: AppDimens.buttonHeight35,
                //         buttonWidth: 80,
                //         fontSize: AppDimens.textSize15,
                //       ),
                //     ),
                //     10.w,
                //     Expanded(
                //       child: CustomButton(
                //         padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                //         text: "Edit",
                //         onPressed: () {
                //           context.pushNamed(
                //             RoutesName.editLeadScreen,
                //             extra: leads
                //           );
                //         },
                //         borderRadius: AppDimens.radius10,
                //         isActive: true,
                //         buttonHeight: AppDimens.buttonHeight35,
                //         buttonWidth: 80,
                //         fontSize: AppDimens.textSize15,
                //       ),
                //     ),
                //   ],
                // ),
          
                // Divider(thickness: 1, color: Colors.grey[300]),
              ],
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(
                  RoutesName.leadScreen,
                  extra: leads.id
                );
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