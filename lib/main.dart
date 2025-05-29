import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joes_jwellery_crm/core/routes/app_routes.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/dependency_injection.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/call/call_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/dashboard/dashboard_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sms/sms_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/task/task_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/whatsapp/whatsapp_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<DashboardCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<CustomerCubit>()),
        BlocProvider(create: (context) => getIt<CallCubit>()),
        BlocProvider(create: (context) => getIt<SmsCubit>()),
        BlocProvider(create: (context) => getIt<WhatsappCubit>()),
        BlocProvider(create: (context) => getIt<LeadsCubit>()),
        BlocProvider(create: (context) => getIt<TaskCubit>()),
        BlocProvider(create: (context) => getIt<SaleCubit>())
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: MaterialApp.router(
          title: 'Joes Jewelry',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          routerConfig: AppRoutes.router,
        ),
      ),
    );
  }
}
