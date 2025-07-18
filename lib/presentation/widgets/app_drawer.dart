// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

class AppDrawer extends StatelessWidget {
  final void Function(String)? onItemSelected;

  const AppDrawer({super.key, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Drawer(
      // width: width /1.4,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppDimens.spacing30, vertical: AppDimens.spacing25),
            width: width * 0.35,
            height: AppDimens.buttonHeight50,
            child: Image.asset(AssetsConstant.joesLogo, fit: BoxFit.contain),
          ),
          
          ListTile(
            // leading: const Icon(Icons.home),
            title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: () {
              context.pop();
              context.read<DashboardCubit>().changeIndex(2);
              // context.goNamed(RoutesName.dashboardScreen);
              onItemSelected?.call('Home');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.person),
            title: const Text('Customers', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.customerScreen);
              onItemSelected?.call('Customers');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.person),
            title: const Text('Wishlist', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.allWishlistScreen);
              onItemSelected?.call('Wishlist');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.taskListScreen);
              onItemSelected?.call('Tasks');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Sales', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.saleScreen);
              onItemSelected?.call('Sales');
            },
          ),
          
          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Reports', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.reposrtsScreen);
              onItemSelected?.call('Reports');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Leads', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.searchLeadsScreen);
              onItemSelected?.call('Leads');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Email Templates', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.emailTemplatesScreen);
              onItemSelected?.call('Email Templates');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Email Campaigns', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.emailCampaignScreen);
              onItemSelected?.call('Email Campaigns');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('SMS Templates', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              showAppSnackBar(context, message: "Coming Soon !");
              onItemSelected?.call('SMS Templates');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('SMS Campaigns', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              showAppSnackBar(context, message: "Coming Soon !");
              onItemSelected?.call('SMS Campaigns');
            },
          ),

          ListTile(
            // leading: const Icon(Icons.task),
            title: const Text('Free Items', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              context.pop();
              context.pushNamed(RoutesName.freeItemsScreen);
              onItemSelected?.call('Free Items');
            },
          ),
          
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () async{
              context.pop();
              bool isSuccess = await context.read<AuthCubit>().logout();
              if(isSuccess){
                showAppSnackBar(context, message: "logged out succesfuly", backgroundColor: AppColor.green);
                context.goNamed(RoutesName.loginScreen);
              }else{
                showAppSnackBar(context, message: "Something went wrong in logging out..");
              }
              onItemSelected?.call('Logout');
            },
          ),
        ],
      ),
    );
  }
}
