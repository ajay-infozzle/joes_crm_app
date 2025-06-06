// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/api_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/data/model/water_taxi_report_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class WaterTaxiReportTile extends StatelessWidget {
  final WaterTaxiEmailReportData report;
  const WaterTaxiReportTile({super.key, required this.report});

  String getStore(BuildContext context, String storeId){
    final store = context.read<HomeCubit>().storeList.firstWhere(
      (e) => e.id == storeId,
      orElse: () => Stores(id: storeId, name: '_'),
    );

    return store.name ?? '_' ;
  }

  String getUser(BuildContext context, String userId){
    final user = context.read<HomeCubit>().usersList.firstWhere(
      (e) => e.id == userId,
      orElse: () => Users(id: userId, name: '_'),
    );

    return user.name ?? '_' ;
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
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8, horizontal: AppDimens.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("ID : ${report.id}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                    AppDimens.spacing8.w,
          
                    const Text("|", style: TextStyle(color: Colors.grey)),
          
                    AppDimens.spacing8.w,
                    Text("Store : ${getStore(context, report.storeId!)}", style: const TextStyle(fontSize: AppDimens.textSize14,fontWeight: FontWeight.bold)),
                  ],
                ),
                5.h,

                Text(
                  "User : ${getUser(context, report.createdBy!)}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                Text(
                  "Customer id : ${report.customerId}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                Text(
                  "To Email : ${report.toEmail}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                Text(
                  "Send date : ${report.creationDate}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary
                  ),
                ),

                5.h,

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async{
                        final url = Uri.parse('${ApiConstant.demoBaseUrl}/show-pdf-certificate.php?type=watertaxi&id=${report.id}');
                        
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          showAppSnackBar(context, message: "Could not open PDF", backgroundColor: AppColor.red);
                        }
                      }, 
                      child: Text(
                        "View PDF",
                        style: TextStyle(
                          color: AppColor.greenishBlue,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                
              },
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