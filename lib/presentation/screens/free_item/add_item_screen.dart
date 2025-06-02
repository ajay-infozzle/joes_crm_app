import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/free_item/free_item_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class AddFreeItemScreen extends StatefulWidget {
  const AddFreeItemScreen({super.key});

  @override
  State<AddFreeItemScreen> createState() => _AddFreeItemScreenState();
}

class _AddFreeItemScreenState extends State<AddFreeItemScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode surnameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

 
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
            "Add Free Item",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<FreeItemCubit, FreeItemState>(
            listener: (context, state) {
              
            },
            buildWhen: (previous, current) =>  current is FreeItemFormLoading || current is FreeItemFormSaved || current is FreeItemFormError,
            builder: (context, state) {
              FreeItemCubit freeItemCubit = context.read<FreeItemCubit>();

              if (state is FreeItemFormLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.primary),
                );
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                children: [
                  TextfieldTitleTextWidget(title: "Name"),
                  _buildField("Name", nameController, nameFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Surname"),
                  _buildField("Surname", surnameController, surnameFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Email"),
                  _buildField("Email", emailController, emailFocus),
                  30.h,


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Add",
                        onPressed: () {
                          freeItemCubit.addItem(
                            formdata: {
                              'name' : nameController.text,
                              'surname' : surnameController.text,
                              'email' : emailController.text,
                            }
                          );
                        },
                        borderRadius: AppDimens.radius16,
                        isActive: true,
                        buttonHeight: AppDimens.buttonHeight40,
                        fontSize: AppDimens.textSize18,
                      ),
                    ],
                  ),

                  30.h,

                ],
              );
            },
          ),
        ) 
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    bool isEnable = true,
    int maxline = 1,
    TextInputType inputType = TextInputType.text
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

  Widget variableExampleRow(String value1, String value2, String value3){
    return SelectableText.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "{{$value1}} - ",
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.textSize14,
            ),
          ),
          TextSpan(
            text: "$value2 - Fallback: ",
            style: TextStyle(
              color: AppColor.primary,
              fontSize: AppDimens.textSize14,
            ),
          ),
          TextSpan(
            text: value3,
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.textSize14,
            ),
          ),
        ],
      ),
    );
  }
  
}