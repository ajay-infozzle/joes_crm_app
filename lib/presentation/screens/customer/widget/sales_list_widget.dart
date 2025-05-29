import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';

class SalesListWidget extends StatelessWidget {
  final List<Sales>? salesList;
  const SalesListWidget({super.key, required this.salesList});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.7, 
      ),
      child: ListView.builder(
        itemCount: salesList?.length ?? 0,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = salesList![index];
          final associates = item.salesAssociates!.map((e) => e.name).join(', ');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "ID : ${item.id}",
                      style: const TextStyle(
                        fontSize: AppDimens.textSize14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppDimens.spacing8.w,
                    const Text("|", style: TextStyle(color: Colors.grey)),
                    AppDimens.spacing8.w,
                    Text(
                      "Store : ${item.store}",
                      style: const TextStyle(
                        fontSize: AppDimens.textSize14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                5.h,

                Text(
                  "Sale Date : ${item.saleDate}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary,
                  ),
                ),

                Text(
                  "Amount : ${item.amount}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary,
                  ),
                ),

                Text(
                  "Associates : $associates",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: AppColor.primary,
                  ),
                ),

                Divider(thickness: 1, color: Colors.grey[300]),
              ],
            ),
          );
        },
      ),
    );
  }
}
