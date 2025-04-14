import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joes_jwellery_crm/core/routes/app_routes.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        title: 'Joes Jwellery',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          textTheme: GoogleFonts.montserratTextTheme()
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}