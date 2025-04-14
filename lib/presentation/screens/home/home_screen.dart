import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/home/widget/log_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          width: width*0.33,
          child: Image.asset(
            AssetsConstant.joesLogo,
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.primary,), 
          onPressed: () {}
        ),
        actions: [
          IconButton(
            icon: Image.asset(AssetsConstant.searchIcon, width: AppDimens.spacing20, height: AppDimens.spacing22, color: AppColor.primary), 
            onPressed: () {}
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: ListView(
            children: [
              AppDimens.spacing10.h,
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesName.customerScreen);
                },
                child: SizedBox(
                  width: width,
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(6, (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(radius: 30, backgroundColor: Colors.grey.shade300),
                      );
                    }),
                  ),
                ),
              ),
              AppDimens.spacing15.h,

              LogSectionWidget(
                title: "Phone Logs",
                assetIcon: AssetsConstant.incomingIcon,
                names: ["James Joseph", "Sherlyn C", "Jovita P"],
                onTap: () {}, 
              ),

              LogSectionWidget(
                title: "WhatsApp",
                assetIcon: AssetsConstant.whatsappIcon, 
                names: ["James Joseph", "Sherlyn C"],
                onTap: () {},
              ),

              LogSectionWidget(
                title: "Email",
                assetIcon: AssetsConstant.emailIcon, 
                names: ["James Joseph", "James Joseph"],
                onTap: () {},
              ),
            ],
          ),
        ) 
      ),
    );
  }
}