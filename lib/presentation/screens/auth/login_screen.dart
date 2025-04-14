import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/password_input_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/remember_me_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/username_input_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: AppColor.greenishGrey,
            child: ListView(
              children: [
                AppDimens.spacing20.h,
                Container(
                  width: width,
                  height: height*0.08,
                  margin: EdgeInsets.only(top: height*0.03, bottom: height*0.04), 
                  padding: EdgeInsetsDirectional.symmetric(horizontal: AppDimens.spacing15),
                  child: Image.asset(AssetsConstant.joesLogo, fit: BoxFit.contain,),
                ),
      
                Container(
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width*0.06),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(AppDimens.radius26)
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        AppDimens.spacing30.h,
                    
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: width*0.055
                            ),
                          ),
                        ),
                    
                        AppDimens.spacing30.h,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*0.04),
                          child: TextfieldTitleTextWidget(title: "Username"),
                        ),
                        Container(
                          width: width,
                          padding: EdgeInsets.only(left: width*0.04, right: width*0.04, top: width*0.02),
                          child: UsernameInputWidget()
                        ),
                    
                        AppDimens.spacing20.h,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*0.04),
                          child: TextfieldTitleTextWidget(title: "Password"),
                        ),
                        Container(
                          width: width,
                          padding: EdgeInsets.only(left: width*0.04, right: width*0.04, top: width*0.02),
                          child: PasswordInputWidget()
                        ),
      
      
                        AppDimens.spacing20.h,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width*0.04),
                          child: RememberMeWidget(
                            onTap: (onChange) {
                              setState(() {
                                remember = onChange ?? false;
                                log("rem->$remember");
                              });
                            }, 
                            isChecked: remember
                          ),
                        ),
                        AppDimens.spacing20.h,
      
                        CustomButton(
                          padding: EdgeInsets.symmetric(horizontal: width*0.05),
                          text: "Login", 
                          onPressed: (){
                            context.goNamed(RoutesName.dashboardScreen);
                          },
                          borderRadius: AppDimens.radius16,
                          isActive: true,
                          buttonHeight: AppDimens.buttonHeight40,
                          fontSize: width*0.04,
                        ),
                    
                        AppDimens.spacing30.h,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ) 
        ),
      ),
    );
  }
}