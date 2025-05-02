import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/call/call_logs_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/email_list_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/home/home_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/sms/sms_chat_list_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/whatsapp/whatsapp_chat_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // int index = 2;
  
  // final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> _pages = [
    CallLogsScreen(),
    SmsChatListScreen(),
    HomeScreen(),
    EmailListScreen(),
    WhatsappChatListScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {"icon": AssetsConstant.callIcon, "label": "Call"},
    {"icon": AssetsConstant.smsIcon, "label": "SMS"},
    {"icon": AssetsConstant.homeIcon, "label": "Home"},
    {"icon": AssetsConstant.emailIcon, "label": "Email"},
    {"icon": AssetsConstant.whatsappIcon, "label": "Whatsapp"},
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        backgroundColor: AppColor.greenishGrey,
        bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
          buildWhen: (previous, current) => current is DashboardIndexChange || current is DashboardInitial,
          builder: (context, state) {
            return CurvedNavigationBar(
              items:
                  _navItems.asMap().entries.map((entry) {
                    int i = entry.key;
                    var item = entry.value;
                    return CurvedNavigationBarItem(
                      child: Image.asset(
                        item["icon"],
                        width: AppDimens.spacing22,
                        height: AppDimens.spacing22,
                        color: AppColor.primary,
                      ),
                      label: context.read<DashboardCubit>().index == i
                              ? ''
                              : item["label"],
                      labelStyle: TextStyle(
                        fontSize: AppDimens.textSize12,
                        color: AppColor.primary,
                      ),
                    );
                  }).toList(),
              color: AppColor.white,
              buttonBackgroundColor: AppColor.white,
              backgroundColor: AppColor.greenishGrey.withValues(alpha: 0.3),
              onTap: (selectedIndex) => context.read<DashboardCubit>().changeIndex(selectedIndex),
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              index: context.read<DashboardCubit>().index,
            );
          },
        ),
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            buildWhen: (previous, current) => current is DashboardIndexChange || current is DashboardInitial,
            builder: (context, state) {
              // return PageStorage(
              //   bucket: bucket,
              //   child: _pages[context.read<DashboardCubit>().index],
              // );

              return IndexedStack(
                index: context.read<DashboardCubit>().index,
                children: _pages,
              );
            },
          ),
        ),
      ),
    );
  }
}
