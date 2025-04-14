import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class EmailThreadItemWidget extends StatefulWidget {
  final Map<String, dynamic> email;
  final bool isInitiallyExpanded;

  const EmailThreadItemWidget({super.key, required this.email, this.isInitiallyExpanded = false});

  @override
  State<EmailThreadItemWidget> createState() => _EmailThreadItemWidgetState();
}

class _EmailThreadItemWidgetState extends State<EmailThreadItemWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20, 
                backgroundColor: AppColor.greenishGrey,
                child: Text(
                  widget.email['sender'][0], 
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              12.w,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.email['sender'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimens.textSize16,
                            color: AppColor.primary
                          ),
                        ),

                        5.w,

                        Text(
                          widget.email['date'],
                          style: const TextStyle(
                            fontSize: AppDimens.textSize12,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),

                    (widget.email['info'] != null && isExpanded)
                      ?Text(
                        widget.email['info'],
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                      : !isExpanded ? Text(
                        widget.email['message'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ) : const SizedBox(),
                  ],
                ),
              ),

              5.w,

              IconButton(
                icon: Image.asset(AssetsConstant.replyIcon, width: AppDimens.spacing20, height: AppDimens.spacing20, color: AppColor.primary), 
                onPressed: () {}
              ),

              IconButton(
                padding: EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.more_vert, size: 20),
                onPressed: () {},
              ),
            ],
          ),

          20.h,

          isExpanded ?
          Text(
            widget.email['message'],
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ) : const SizedBox(),

          const Divider(height: 30),
        ],
      ),
    );
  }
}