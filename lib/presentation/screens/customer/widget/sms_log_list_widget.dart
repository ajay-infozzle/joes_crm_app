import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';

class SmsLogListWidget extends StatelessWidget {
  final List<SmsLog>? smsLogList;
  const SmsLogListWidget({super.key, required this.smsLogList});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.7,
      ),
      child: ListView.builder(
        itemCount: smsLogList?.length ?? 0,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = smsLogList![index];
          final dateTime = DateFormat('dd/MM/yy, HH:mm').format(DateTime.parse(item.date ?? ""));

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8),
            child: Row(
              children: [
                if (item.type == "outgoing")
                  const Expanded(flex: 1, child: SizedBox()),

                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.spacing10),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(20, item.type == "incoming" ? 20 : 30),
                        bottomRight: Radius.elliptical(20, item.type == "incoming" ? 30 : 20),
                        topLeft: Radius.circular(item.type == "outgoing" ? AppDimens.spacing10 : 0),
                        topRight: Radius.circular(item.type == "incoming" ? AppDimens.spacing10 : 0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                          children: [
                            Image.asset(
                              AssetsConstant.chatIcon,
                              width: AppDimens.spacing15,
                              height: AppDimens.spacing15,
                              color: AppColor.primary,
                            ),
                            AppDimens.spacing8.w,
                            Text(
                              "${item.from}",
                              style: const TextStyle(
                                fontSize: AppDimens.textSize14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        5.h,

                        HtmlWidget(
                          item.message ?? '',
                          textStyle: TextStyle(
                            fontSize: AppDimens.textSize14,
                            color: AppColor.primary,
                          ),
                        ),
                        5.h,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              dateTime,
                              style: TextStyle(
                                fontSize: AppDimens.textSize10,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                if (item.type == "incoming")
                  const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          );
        },
      ),
    );
  }
}
