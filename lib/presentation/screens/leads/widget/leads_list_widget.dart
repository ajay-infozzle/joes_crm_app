import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';


class LeadsListWidget extends StatelessWidget {
  final Leads leads ;
  const LeadsListWidget({super.key, required this.leads});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8),
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

          Divider(thickness: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }
}