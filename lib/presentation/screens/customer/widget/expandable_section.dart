import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final Map<String, String>? content;

  const ExpandableSection({super.key, required this.title, this.content});

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = true;

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

          if (_isExpanded && widget.content != null)
            Container(
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
                child: Column(
                  children: widget.content!.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing8),
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}
