import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    navigate();
  }
  
  void navigate() async{
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        // ignore: use_build_context_synchronously
        context.goNamed(RoutesName.loginScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: SizedBox(
            width: width*0.6,
            height: height*0.1,
            child: Image.asset(
              AssetsConstant.joesLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}