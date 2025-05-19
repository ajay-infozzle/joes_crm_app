// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/home/widget/header_items.dart';
import 'package:joes_jwellery_crm/presentation/screens/home/widget/log_section_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_drawer.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List headerItem = [
    {
      "title" : "New Customer",
      "icon"  : AssetsConstant.newCustIcon
    },
    {
      "title" : "Search Customer",
      "icon"  : AssetsConstant.custSearchIcon
    },
    {
      "title" : "New Lead",
      "icon"  : AssetsConstant.newLeadsIcon
    },
    {
      "title" : "Search Lead",
      "icon"  : AssetsConstant.custSearchIcon
    },
    {
      "title" : "View Tasks",
      "icon"  : AssetsConstant.taskIcon
    },
    {
      "title" : "Logout",
      "icon"  : AssetsConstant.logoutIcon
    }
  ];

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
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColor.primary),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.logout,
          //     color: AppColor.primary,
          //     size: AppDimens.spacing22,
          //   ),
          //   onPressed: () async{
          //     bool isSuccess = await context.read<AuthCubit>().logout();
          //     if(isSuccess){
          //       showAppSnackBar(context, message: "logged out succesfuly", backgroundColor: AppColor.green);
          //       context.goNamed(RoutesName.loginScreen);
          //     }else{
          //       showAppSnackBar(context, message: "Something went wrong in logging out..");
          //     }
          //   },
          // ),
        ],
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColor.primary,));
              }
              else if (state is HomeError) {
                return RetryWidget(
                  onTap: () async{
                    await context.read<HomeCubit>().fetchHomeData();
                  },
                );
              }
              else if(state is HomeLoaded){
                // final phoneLogs = state.homeData.phoneLogs ?? [];
                final phoneLogs = (state.homeData.phoneLogs ?? []).take(5).toList();
            
                return RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: () async {
                    await context.read<HomeCubit>().fetchHomeData();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      AppDimens.spacing10.h,

                      HeaderItemList(
                        items: headerItem.map((e) => {
                          "title": e['title'],
                          "icon": e['icon']
                        }).toList(),
                        onTap: (index) async{
                          final title = headerItem[index]['title'];

                          switch (title) {
                            case "Logout":
                              bool isSuccess = await context.read<AuthCubit>().logout();
                              if(isSuccess){
                                showAppSnackBar(context, message: "logged out succesfuly", backgroundColor: AppColor.green);
                                context.goNamed(RoutesName.loginScreen);
                              }else{
                                showAppSnackBar(context, message: "Something went wrong in logging out..");
                              }
                              break;
                            case "New Customer":
                              context.pushNamed(RoutesName.searchCustomerScreen);
                              break;
                            case "Search Customer":
                              context.pushNamed(RoutesName.customerScreen);
                              break;
                            case "New Lead":
                              context.pushNamed(RoutesName.addLeadsScreen);
                              break;
                            case "Search Lead":
                              context.pushNamed(RoutesName.searchLeadsScreen);
                              break;
                            case "View Tasks":
                              // context.pushNamed(RoutesName.customerScreen);
                              break;
                            default:
                              break;
                          }
                        },
                      ),
                      AppDimens.spacing10.h,
                  
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
                        onTap: () {
                          context.read<DashboardCubit>().changeIndex(0);
                        },
                      ),
                  
                      LogSectionWidget(
                        title: "WhatsApp",
                        assetIcon: [
                          AssetsConstant.whatsappIcon,
                          AssetsConstant.whatsappIcon,
                        ],
                        names: ["James Joseph", "Sherlyn C"],
                        onTap: () {
                          context.read<DashboardCubit>().changeIndex(4);
                        },
                      ),
                  
                      LogSectionWidget(
                        title: "Email",
                        assetIcon: [
                          AssetsConstant.emailIcon,
                          AssetsConstant.emailIcon,
                        ],
                        names: ["James Joseph", "James Joseph"],
                        onTap: () {
                          context.read<DashboardCubit>().changeIndex(3);
                        },
                      ),
                    ],
                  ),
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
