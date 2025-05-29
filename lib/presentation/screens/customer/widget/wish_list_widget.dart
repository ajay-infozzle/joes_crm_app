import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';

class WishListWidget extends StatelessWidget {
  final List<WishList>? wishList;
  const WishListWidget({super.key, required this.wishList});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.7,
      ),
      child: ListView.builder(
        itemCount: wishList?.length ?? 0,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = wishList![index];
          final associates = item.salesAssociates!.map((e) => e.name).join(', ');

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product : ${item.product}",
                            style: const TextStyle(
                              fontSize: AppDimens.textSize14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ID : ${item.id}",
                            style: TextStyle(
                              fontSize: AppDimens.textSize14,
                              color: AppColor.primary,
                            ),
                          ),
                          Text(
                            "Price : ${item.price}",
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
                        ],
                      ),
                    ),
                    5.w,
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        item.photo!.isNotEmpty
                            ? "https://joescrm.mydemoweblink.com/${item.photo}"
                            : "",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
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
