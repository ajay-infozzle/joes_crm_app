import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';


class LeadsSearchListWidget extends StatelessWidget {
  final Leads leads ;
  const LeadsSearchListWidget({super.key, required this.leads});

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

          10.h,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                  text: "View",
                  onPressed: () {
                
                  },
                  borderRadius: AppDimens.radius10,
                  isActive: true,
                  buttonHeight: AppDimens.buttonHeight35,
                  buttonWidth: 80,
                  fontSize: AppDimens.textSize15,
                ),
              ),
              10.w,
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing10),
                  text: "Edit",
                  onPressed: () {
                
                  },
                  borderRadius: AppDimens.radius10,
                  isActive: true,
                  buttonHeight: AppDimens.buttonHeight35,
                  buttonWidth: 80,
                  fontSize: AppDimens.textSize15,
                ),
              ),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }
}