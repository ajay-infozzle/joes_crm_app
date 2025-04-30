import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/home/widget/log_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          width: width * 0.33,
          child: Image.asset(AssetsConstant.joesLogo, fit: BoxFit.contain),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColor.primary),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AssetsConstant.searchIcon,
              width: AppDimens.spacing20,
              height: AppDimens.spacing22,
              color: AppColor.primary,
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColor.primary,));
              }
              else if(state is HomeLoaded){
                final phoneLogs = state.homeData.phoneLogs ?? [];
                // if(phoneLogs.length > 5){
                //   phoneLogs.fillRange(0, 4);
                // }
            
                return ListView(
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
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade300,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    AppDimens.spacing15.h,

                    LogSectionWidget(
                      title: "Phone Logs",
                      assetIcon: phoneLogs.map((log) {
                        switch (log.callType) {
                          case 'incoming': return AssetsConstant.incomingIcon;
                          case 'outgoing': return AssetsConstant.outgoingIcon;
                          case 'missed': return AssetsConstant.missedCallIcon;
                          default: return AssetsConstant.missedCallIcon;
                        }
                      }).toList(),
                      names: phoneLogs.map((e) => e.customerName ?? "").toList(),
                      onTap: () {},
                    ),

                    LogSectionWidget(
                      title: "WhatsApp",
                      assetIcon: [
                        AssetsConstant.whatsappIcon,
                        AssetsConstant.whatsappIcon,
                      ],
                      names: ["James Joseph", "Sherlyn C"],
                      onTap: () {},
                    ),

                    LogSectionWidget(
                      title: "Email",
                      assetIcon: [
                        AssetsConstant.emailIcon,
                        AssetsConstant.emailIcon,
                      ],
                      names: ["James Joseph", "James Joseph"],
                      onTap: () {},
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
