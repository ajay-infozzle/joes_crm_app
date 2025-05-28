import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/data/model/leads_model.dart';
import 'package:joes_jwellery_crm/data/model/single_task_model.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/login_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/add_customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/customer_detail_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/search_customer_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/email_thread_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/add_leads_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/edit_leads_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/lead_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/search_lead_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/splash_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_edit_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_list_screen.dart';
import 'package:joes_jwellery_crm/presentation/screens/task/task_screen.dart';

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