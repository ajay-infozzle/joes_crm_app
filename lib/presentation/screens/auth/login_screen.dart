import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/auth/auth_state.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/password_input_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/remember_me_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/username_input_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
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
                  height: height * 0.08,
                  margin: EdgeInsets.only(
                    top: height * 0.03,
                    bottom: height * 0.04,
                  ),
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: AppDimens.spacing15,
                  ),
                  child: Image.asset(
                    AssetsConstant.joesLogo,
                    fit: BoxFit.contain,
                  ),
                ),

                Container(
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: width * 0.06),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(AppDimens.radius26),
                  ),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is AuthAuthenticated){
                        context.goNamed(RoutesName.dashboardScreen);
                      }

                      if(state is AuthUnauthenticated){
                        log("Authentication failed >>", name: "Login Screen");
                        showAppSnackBar(context, message: 'Authentication Failed');
                      }

                      if(state is AuthError){
                        log("Authentication Error >>", name: "Login Screen");
                        showAppSnackBar(context, message: state.message);
                      }
                    },
                    builder: (context, state) {
                      return Form(
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
                                  fontSize: width * 0.055,
                                ),
                              ),
                            ),

                            AppDimens.spacing30.h,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              child: TextfieldTitleTextWidget(
                                title: "Username",
                              ),
                            ),
                            Container(
                              width: width,
                              padding: EdgeInsets.only(
                                left: width * 0.04,
                                right: width * 0.04,
                                top: width * 0.02,
                              ),
                              child: UsernameInputWidget(
                                controller: usernameController,
                                focusNode: usernameFocusNode,
                                enabled: state is! AuthLoading,
                                onChanged: (value) {
                                  if(usernameController.text.isEmpty){
                                    context.read<AuthCubit>().checkInputFields(
                                      usernameController.text, 
                                      passwordController.text
                                    );
                                  }
                                },
                              ),
                            ),

                            AppDimens.spacing20.h,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              child: TextfieldTitleTextWidget(
                                title: "Password",
                              ),
                            ),
                            Container(
                              width: width,
                              padding: EdgeInsets.only(
                                left: width * 0.04,
                                right: width * 0.04,
                                top: width * 0.02,
                              ),
                              child: PasswordInputWidget(
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                enabled: state is! AuthLoading,
                                onChanged: (value) {
                                  context.read<AuthCubit>().checkInputFields(
                                    usernameController.text, 
                                    passwordController.text
                                  );
                                },
                              ),
                            ),

                            AppDimens.spacing20.h,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              child: RememberMeWidget(
                                onTap: (onChange) {
                                  context.read<AuthCubit>().toggleRememberMe(
                                    onChange ?? false,
                                  );
                                },
                                isChecked: context.read<AuthCubit>().rememberMe,
                              ),
                            ),
                            AppDimens.spacing20.h,

                            state is AuthLoading 
                            ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primary, 
                              ),
                            )
                            :CustomButton(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              text: "Login",
                              onPressed: () {
                                // print(context.read<AuthCubit>().username.isNotEmpty && context.read<AuthCubit>().password.isNotEmpty);
                                FocusScope.of(context).unfocus();

                                context.read<AuthCubit>().login(
                                  usernameController.text.trim(),
                                  passwordController.text.trim(),
                                );
                                // context.goNamed(RoutesName.dashboardScreen);
                              },
                              borderRadius: AppDimens.radius16,
                              isActive: (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty),
                              buttonHeight: AppDimens.buttonHeight40,
                              fontSize: AppDimens.textSize18,
                            ),

                            AppDimens.spacing30.h,
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
