import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/customer_list_model.dart';


class CustomerTile extends StatelessWidget {
  final Customers customer;
  final VoidCallback onView;

  const CustomerTile({super.key, required this.customer, required this.onView});

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
                        customer.name ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimens.textSize16),
                      ),

                      AppDimens.spacing6.h,

                      Row(
                        children: [
                          Text("ID : ${customer.id}", style: const TextStyle(fontSize: AppDimens.textSize14)),
                          AppDimens.spacing8.w,

                          const Text("|", style: TextStyle(color: Colors.grey)),

                          AppDimens.spacing8.w,
                          Text("Store : ${customer.store}", style: const TextStyle(fontSize: AppDimens.textSize14)),
                        ],
                      ),
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
              onTap: onView,
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
