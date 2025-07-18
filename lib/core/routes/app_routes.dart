import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/data/model/email_templates_model.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';
import 'package:joes_jwellery_crm/data/model/single_task_model.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/login_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/campaign/email_campaign_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/campaign/single_email_campaign_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/add_customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/customer_detail_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/search_customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/add_email_template_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/edit_email_template_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/email_templates_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/email_thread_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/single_email_template_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/free_item/add_item_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/free_item/free_items_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/add_leads_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/edit_leads_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/lead_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/search_lead_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/reports_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/sales/add_sale_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/sales/sales_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/sales/single_sale_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/splash_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_edit_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_list_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/wishlist/add_wish_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/wishlist/all_wishlist_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/wishlist/edit_wish_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/wishlist/single_wish_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: RoutesName.splashScreen,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: RoutesName.loginScreen,
            name: RoutesName.loginScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const LoginScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.dashboardScreen,
            name: RoutesName.dashboardScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const DashboardScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.searchLeadsScreen,
            name: RoutesName.searchLeadsScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const SearchLeadScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.addLeadsScreen,
            name: RoutesName.addLeadsScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const AddLeadsScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.leadScreen,
            name: RoutesName.leadScreen,
            pageBuilder: (context, state) {
              final String id = state.extra as String;
              return customPageRouteBuilder(
                LeadScreen(id: id),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.editLeadScreen,
            name: RoutesName.editLeadScreen,
            pageBuilder: (context, state) {
              final Leads lead = state.extra as Leads;
              return customPageRouteBuilder(
                EditLeadsScreen(
                  leads: lead,
                ),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.taskListScreen,
            name: RoutesName.taskListScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const TaskListScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.taskScreen,
            name: RoutesName.taskScreen,
            pageBuilder: (context, state) {
              final String id = state.extra as String;
              return customPageRouteBuilder(
                TaskScreen(id: id),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.editTaskScreen,
            name: RoutesName.editTaskScreen,
            pageBuilder: (context, state) {
              final Task task = state.extra as Task;
              return customPageRouteBuilder(
                TaskEditScreen(task: task),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.saleScreen,
            name: RoutesName.saleScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const SalesScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.singleSaleScreen,
            name: RoutesName.singleSaleScreen,
            pageBuilder: (context, state) {
              final String saleId = state.extra as String;
              return customPageRouteBuilder(
                SingleSaleScreen(saleId: saleId),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.addSaleScreen,
            name: RoutesName.addSaleScreen,
            pageBuilder: (context, state) {
              final String custId = state.extra as String;
              return customPageRouteBuilder(
                AddSaleScreen(custId: custId),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.customerScreen,
            name: RoutesName.customerScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const CustomerScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.searchCustomerScreen,
            name: RoutesName.searchCustomerScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const SearchCustomerScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.addCustomerScreen,
            name: RoutesName.addCustomerScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const AddCustomerScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.customerDetailScreen,
            name: RoutesName.customerDetailScreen,
            pageBuilder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final name = extra?['name'] as String? ?? '';
              final id = extra?['id'] as String? ?? '';
              return customPageRouteBuilder(
                CustomerDetailScreen(name: name, id: id),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.emailThreadScreen,
            name: RoutesName.emailThreadScreen,
            pageBuilder: (context, state) {
              final thread = state.extra as List<Map<String, dynamic>>?;
              return customPageRouteBuilder(
                EmailThreadScreen(threadMessages: thread??[]),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.emailTemplatesScreen,
            name: RoutesName.emailTemplatesScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const EmailTemplatesScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.singleEmailTemplateScreen,
            name: RoutesName.singleEmailTemplateScreen,
            pageBuilder: (context, state) {
              final tempId = state.extra as String ;
              return customPageRouteBuilder(
                SingleEmailTemplateScreen(
                  tempId: tempId,
                ),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.editEmailTemplateScreen,
            name: RoutesName.editEmailTemplateScreen,
            pageBuilder: (context, state) {
              final template = state.extra as Emailtpls ;
              return customPageRouteBuilder(
                EditEmailTemplateScreen(template: template),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.addEmailTemplateScreen,
            name: RoutesName.addEmailTemplateScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const AddEmailTemplateScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          /// free item
          GoRoute(
            path: RoutesName.freeItemsScreen,
            name: RoutesName.freeItemsScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const FreeItemsScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.addFreeItemScreen,
            name: RoutesName.addFreeItemScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const AddFreeItemScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          /// wishlist
          GoRoute(
            path: RoutesName.addWishScreen,
            name: RoutesName.addWishScreen,
            pageBuilder: (context, state) {
              final custId = state.extra as String ;
              return customPageRouteBuilder(
                AddWishScreen(custId: custId,),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.editWishScreen,
            name: RoutesName.editWishScreen,
            pageBuilder: (context, state) {
              final wishData = state.extra as  Wish;
              return customPageRouteBuilder(
                EditWishScreen(wishData: wishData),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.allWishlistScreen,
            name: RoutesName.allWishlistScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const AllWishlistScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.singleWishScreen,
            name: RoutesName.singleWishScreen,
            pageBuilder: (context, state) {
              final wishId = state.extra as String ;
              return customPageRouteBuilder(
                SingleWishScreen(wishId: wishId),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          /// reports
          GoRoute(
            path: RoutesName.reposrtsScreen,
            name: RoutesName.reposrtsScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const ReportsScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          /// campaign
          GoRoute(
            path: RoutesName.emailCampaignScreen,
            name: RoutesName.emailCampaignScreen,
            pageBuilder: (context, state) {
              return customPageRouteBuilder(
                const EmailCampaignScreen(),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),

          GoRoute(
            path: RoutesName.singleEmailCampaignScreen,
            name: RoutesName.singleEmailCampaignScreen,
            pageBuilder: (context, state) {
              final campgnId = state.extra as String ;
              return customPageRouteBuilder(
                SingleEmailCampaignScreen(campgnId: campgnId),
                state.pageKey, 
                transitionDuration: const Duration(milliseconds: 500)
              );
            },
          ),
        ] 
      )
    ] 
  );
}


CustomTransitionPage customPageRouteBuilder(Widget page, LocalKey pageKey, {required Duration transitionDuration}) {
  return CustomTransitionPage(
    key: pageKey,
    child: page,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: transitionDuration,
  );
}


CustomTransitionPage customPageRouteBuilderBottomToTop(Widget page, LocalKey pageKey, {required Duration transitionDuration}) {
  return CustomTransitionPage(
    key: pageKey,
    child: page,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: transitionDuration,
  );
}