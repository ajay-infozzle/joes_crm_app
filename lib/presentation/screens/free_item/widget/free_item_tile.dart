import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/free_item_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';

class FreeItemTile extends StatelessWidget {
  final Freeitems item ;
  final VoidCallback onDelete ;
  const FreeItemTile({super.key, required this.item, required this.onDelete});

  String getUserName(BuildContext context, String userId) {
    String name = "_";
    context.read<HomeCubit>().usersList.forEach((e) {
      if (userId == e.id) {
        name = e.name ?? "_";
      }
    });
    return name.toLowerCase().capitalizeFirst();
  }

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
            padding: const EdgeInsets.all(AppDimens.spacing15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${item.name} ${item.surname}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimens.textSize16),
                      ),

                      AppDimens.spacing4.h,

                      Text(item.email??"", style: const TextStyle(fontSize: AppDimens.textSize14)),

                      Text("Created on : ${formatDateTime(item.creationDate??"")['date']}", style: const TextStyle(fontSize: AppDimens.textSize14)),

                      Text("Created by : ${getUserName(context,item.createdBy ?? "")}", style: const TextStyle(fontSize: AppDimens.textSize14)),

                      // Row(
                      //   children: [
                      //     Text("Created on : ${item.creationDate}", style: const TextStyle(fontSize: AppDimens.textSize14)),
                      //     AppDimens.spacing8.w,

                      //     const Text("|", style: TextStyle(color: Colors.grey)),

                      //     // AppDimens.spacing8.w,
                      //     // Text("Approved : ${template.approved == '1'?"Yes":"No"}", style: const TextStyle(fontSize: AppDimens.textSize14)),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: AppDimens.buttonHeight30,
                height: AppDimens.buttonHeight30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.red.withValues(alpha: .1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimens.spacing12),
                    bottomLeft: Radius.circular(AppDimens.spacing12)
                  )
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  size: AppDimens.spacing18,
                  color: AppColor.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}