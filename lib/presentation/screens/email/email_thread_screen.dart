import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/email_thread_item_widget.dart';

class EmailThreadScreen extends StatelessWidget {
  final List<Map<String, dynamic>> threadMessages;

  const EmailThreadScreen({super.key, required this.threadMessages});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubjectSection(),
              
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: threadMessages.length,
                  itemBuilder: (context, index) {
                    return EmailThreadItemWidget(
                      email: threadMessages[index],
                      isInitiallyExpanded: index == threadMessages.length - 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColor.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColor.primary),
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        IconButton(
          icon: Image.asset(AssetsConstant.replyIcon, width: AppDimens.spacing20, height: AppDimens.spacing20, color: AppColor.primary), 
          onPressed: () {}
        ),
        IconButton(
          icon: Image.asset(AssetsConstant.deleteIcon, width: AppDimens.spacing20, height: AppDimens.spacing20, color: AppColor.primary), 
          onPressed: () {}
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildSubjectSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              threadMessages[0]['subject'],
              style: TextStyle(
                fontSize: AppDimens.textSize25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Image.asset(AssetsConstant.starIcon, width: 24, height: 24),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

