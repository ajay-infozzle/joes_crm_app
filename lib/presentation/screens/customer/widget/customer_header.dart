import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

class CustomerHeader extends StatelessWidget {
  final Customer customer;
  // final String name;
  const CustomerHeader({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: width*0.05, horizontal: width*0.05),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: .45),
        borderRadius: BorderRadius.circular(AppDimens.radius12),
        border: Border(bottom: BorderSide(color: AppColor.primary.withValues(alpha: .3)))
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: AppDimens.radius24,
            backgroundColor: AppColor.greenishGrey.withValues(alpha: .6),
            backgroundImage: customer.photo != null && customer.photo != "" 
            ? NetworkImage(
              "https://crm.joesjewelry.com${customer.photo}",
            ) 
            :AssetImage(AssetsConstant.personIcon),
            // child: Icon(Icons.person, size: AppDimens.radius26, color: AppColor.white),
          ),

          AppDimens.spacing10.h,

          Text(
            customer.name ?? "",
            style: TextStyle(fontSize: AppDimens.textSize18, fontWeight: FontWeight.bold),
          ),

          AppDimens.spacing15.h,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: AppDimens.radius18,
                backgroundColor: AppColor.greenishGrey,
                child: IconButton(
                  icon: Image.asset(AssetsConstant.whatsappIcon, width: AppDimens.spacing18, height: AppDimens.spacing22, color: AppColor.primary), 
                  onPressed: () {
                    showAppSnackBar(context, message: "Coming soon !", backgroundColor: AppColor.red);
                  }
                ),
              ),

              CircleAvatar(
                radius: AppDimens.radius18,
                backgroundColor: AppColor.greenishGrey,
                child: IconButton(
                  icon: Image.asset(AssetsConstant.callIcon, width: AppDimens.spacing18, height: AppDimens.spacing22, color: AppColor.primary), 
                  onPressed: () {
                    showAppSnackBar(context, message: "Coming soon !", backgroundColor: AppColor.red);
                  }
                ),
              ),

              CircleAvatar(
                radius: AppDimens.radius18,
                backgroundColor: AppColor.greenishGrey,
                child: IconButton(
                  icon: Image.asset(AssetsConstant.emailIcon, width: AppDimens.spacing18, height: AppDimens.spacing22, color: AppColor.primary), 
                  onPressed: () {
                    showAppSnackBar(context, message: "Coming soon !", backgroundColor: AppColor.red);
                  }
                ),
              ),

              CircleAvatar(
                radius: AppDimens.radius18,
                backgroundColor: AppColor.greenishGrey,
                child: IconButton(
                  icon: Image.asset(AssetsConstant.chatIcon, width: AppDimens.spacing18, height: AppDimens.spacing22, color: AppColor.primary), 
                  onPressed: () {
                    showAppSnackBar(context, message: "Coming soon !", backgroundColor: AppColor.red);
                  }
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}