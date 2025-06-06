import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/api_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';

class WishlistTile extends StatelessWidget {
  final Wishlist wish;
  final VoidCallback onView;

  const WishlistTile({super.key, required this.wish, required this.onView});


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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${wish.product}",
                        style: const TextStyle(
                          fontSize: AppDimens.textSize14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.h,

                      Text(
                        "Customer Id: ${wish.customer}",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14,
                          color: AppColor.primary,
                        ),
                      ),
                      Text(
                        "Price : \$ ${wish.price}",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14,
                          color: AppColor.primary,
                        ),
                      ),
                      Text(
                        "Associate : ${getUserName(context,wish.salesAssoc2??"")}",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14,
                          color: AppColor.primary,
                        ),
                      ),
                      Text(
                        "Follow-up : ${formatDateTime(wish.followDate??"")['date']}",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14,
                          color: AppColor.primary,
                        ),
                      ),
                      Text(
                        "Created : ${getUserName(context, wish.createdBy??"")} (${formatDateTime(wish.creationDate??"")['date']})",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                5.w,
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: .1),
                    ),
                    child: Image.network(
                      wish.photo != null && wish.photo!.isNotEmpty
                          ? "${ApiConstant.demoBaseUrl}/index.php?option=com_joecrm&task=file&path=[DIR_WISHLIST_PHOTO]/${wish.photo}"
                          : "",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      // loadingBuilder: (context, child, loadingProgress) => Center(child: CircularProgressIndicator(color: AppColor.primary,),),
                      errorBuilder: (context, error, stackTrace) => Container(color: AppColor.primary.withValues(alpha: .04),),
                    ),
                  ),
                ),
              ],
            ),
            // child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text(
            //             customer.name ?? "",
            //             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimens.textSize16),
            //           ),

            //           AppDimens.spacing6.h,

            //           Row(
            //             children: [
            //               Text("ID : ${customer.id}", style: const TextStyle(fontSize: AppDimens.textSize14)),
            //               AppDimens.spacing8.w,

            //               const Text("|", style: TextStyle(color: Colors.grey)),

            //               AppDimens.spacing8.w,
            //               Text("Store : ${customer.store}", style: const TextStyle(fontSize: AppDimens.textSize14)),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
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