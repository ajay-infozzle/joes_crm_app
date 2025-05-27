import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class SearchCustomerScreen extends StatefulWidget {
  const SearchCustomerScreen({super.key});

  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,

      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: true,
        title: SizedBox(
          child: Text(
            "Search Customer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          color: AppColor.white,
          child: BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if(state is CustomerExistError){
                showAppSnackBar(context, message: state.message);
              }
              if(state is CustomerNotExist){
                context.read<CustomerCubit>().tempCustEmail = searchController.text.trim();
                searchController.clear();

                context.pushReplacementNamed(
                  RoutesName.addCustomerScreen,
                );
              }
            },
            builder: (context, state) {
              if(state is CustomerExistVerifying){
                return Center(child: CircularProgressIndicator(color: AppColor.primary,),);
              }
              return Column(
                children: [
                  5.h,
                  SizedBox(
                    child: Text(
                      "Before adding new client please search by email address.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimens.textSize16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  20.h,

                  TextfieldTitleTextWidget(title: "Email"),
                  _buildField("Enter email", searchController, searchFocus),
                  7.h,

                  Spacer(),

                  Builder(
                    builder: (context) {
                      if(state is CustomerExist){
                        return Column(
                          children: [
                            SizedBox(
                              width: width,
                              child: CustomButton(
                                text: "Go to customer",
                                borderRadius: AppDimens.radius16,
                                backgroundColor: AppColor.green,
                                isActive: true,
                                buttonHeight: AppDimens.buttonHeight50,
                                fontSize: AppDimens.textSize18,
                                onPressed: () {
                                  context.pushNamed(RoutesName.customerDetailScreen, extra: {
                                    "id":state.customers[0].id,
                                    "name":state.customers[0].name
                                  });
                                },
                              ),
                            ),
                            20.h,
                          ],
                        );
                      }else{
                        return SizedBox();
                      }
                    }, 
                  ),

                  SizedBox(
                    width: width,
                    child: CustomButton(
                      text: "Search Customer",

                      borderRadius: AppDimens.radius16,
                      isActive: true,
                      buttonHeight: AppDimens.buttonHeight50,
                      fontSize: AppDimens.textSize18,
                      onPressed: () {
                        context.read<CustomerCubit>().isCustomerExist(formdata: {
                          'query' : searchController.text.trim()
                        });
                      },
                    ),
                  ),

                  20.h,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    bool isEnable = true,
    int maxline = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: label,
        enabled: isEnable,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }
}
