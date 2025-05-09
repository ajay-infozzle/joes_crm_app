import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/activity_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/sales_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/sms_log_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/wish_list_widget.dart';


class ExpandableSection extends StatefulWidget {
  final String title;
  final bool isActivityStream;
  final bool isSales;
  final bool isSmsLogs;
  final bool isWishList;
  final Map<String, String>? content;
  final List<ActivityStream>? activityList;
  final List<Sales>? salesList;
  final List<SmsLog>? smsLogList;
  final List<WishList>? wishList;

  const ExpandableSection({
    super.key, 
    required this.title, 
    this.content,
    this.isActivityStream = false,
    this.isSales = false,
    this.isSmsLogs = false,
    this.isWishList = false,
    this.activityList,
    this.salesList,
    this.smsLogList,
    this.wishList
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.spacing15),
      decoration: BoxDecoration(
        color: AppColor.greenishGrey.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(AppDimens.radius10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: ListTile(
              contentPadding: EdgeInsets.only(left: width*0.04, right: width*0.02),
              minTileHeight: AppDimens.spacing45,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimens.textSize15,
                  color: AppColor.primary
                ),
              ),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
          ),

          if (_isExpanded && (widget.content != null || widget.activityList != null || widget.salesList != null || widget.smsLogList != null || widget.wishList != null))
            Container(
              width: width,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width*0.04, vertical: width*0.03),
                decoration: BoxDecoration(
                  color: AppColor.greenishGrey.withValues(alpha: .4),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
                child: Builder(
                  builder: (context) {
                    if (widget.isActivityStream && widget.activityList != null) {
                      return ActivityListWidget(activityList: widget.activityList);
                    } else if (widget.isSales && widget.salesList != null) {
                      return SalesListWidget(salesList: widget.salesList!); 
                    } else if (widget.isSmsLogs && widget.smsLogList != null) {
                      return SmsLogListWidget(smsLogList: widget.smsLogList!); 
                    } else if (widget.isWishList && widget.wishList != null) {
                      return WishListWidget(wishList: widget.wishList!); 
                    } else if (widget.content != null) {
                      return Column(
                        children: widget.content!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing4),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    entry.key, style: TextStyle(fontSize: AppDimens.textSize14, fontWeight: FontWeight.w500)
                                  ),
                                ),

                                5.w,

                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    entry.value, 
                                    style: const TextStyle(fontSize: AppDimens.textSize14, fontWeight: FontWeight.w400)
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                    else {
                      return const SizedBox(); 
                    }
                  }, 
                )
              ),
            ),
        ],
      ),
    );
  }
}
