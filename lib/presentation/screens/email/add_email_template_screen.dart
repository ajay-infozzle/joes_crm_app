import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/email_type_dropdown.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/template_text_editor.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class AddEmailTemplateScreen extends StatefulWidget {
  const AddEmailTemplateScreen({super.key});

  @override
  State<AddEmailTemplateScreen> createState() => _AddEmailTemplateScreenState();
}

class _AddEmailTemplateScreenState extends State<AddEmailTemplateScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController templController = TextEditingController();

  FocusNode titleFocus = FocusNode();
  FocusNode subjectFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    context.read<EmailCubit>().selectedEmailType = null ;
  }

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
            "Add Template",
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
          child: BlocConsumer<EmailCubit, EmailState>(
            listener: (context, state) {
              
            },
            buildWhen: (previous, current) => current is EmailTemplFormUpdate || current is EmailTemplFormLoading || current is EmailTemplFormSaved || current is EmailTemplFormError,
            builder: (context, state) {
              EmailCubit emailCubit = context.read<EmailCubit>();

              if (state is EmailTemplFormLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.primary),
                );
              }

              return ListView(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                children: [
                  TextfieldTitleTextWidget(title: "Title"),
                  _buildField("Title", titleController, titleFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Subject"),
                  _buildField("Subject", subjectController, subjectFocus, maxline: 3),
                  7.h,

                  TextfieldTitleTextWidget(title: "Type"),
                  5.h,
                  EmailTypeDropdown(
                    typeList: emailCubit.emailTypeList, 
                    onSelected: (selectedType) => emailCubit.changeEmailType(selectedType),
                    initialSelected: emailCubit.selectedEmailType,
                  ),
                  7.h,

                  // TextfieldTitleTextWidget(title: "Approved by admin"),
                  // 5.h,
                  // Row(
                  //   children: [
                  //     RadioBoxButton(
                  //       text: 'Yes',
                  //       groupValue: widget.template.approved == "1" ? 'Yes': 'No',
                  //       value: 'Yes',
                  //       onChanged: (value) {},
                  //     ),
                  //     10.w,
                  //     RadioBoxButton(
                  //       text: 'No',
                  //       groupValue: widget.template.approved == "1" ? 'Yes': 'No',
                  //       value: 'No',
                  //       onChanged: (value) {},
                  //     ),
                  //   ],
                  // ),
                  // 7.h,

                  25.h,
                  TemplEditableTextContainer(controller: templController),
                  25.h,

                  Text(
                    "Template Variables",
                    style: TextStyle(
                      color: AppColor.greenishBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.textSize24
                    ),
                  ),

                  Text(
                    "You can copy/paste the following varibles in the template:",
                    style: TextStyle(
                      color: AppColor.primary,
                      // fontWeight: FontWeight.bold,
                      fontSize: AppDimens.textSize15
                    ),
                  ),

                  Text(
                    "just copy the varible, for example {{customer.name}} and paste it in the template",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize12
                    ),
                  ),
                  10.h,

                  variableExampleRow("name", "Customer Name", "customer"),
                  5.h,
                  variableExampleRow("surname", "Customer Surname", "customer"),
                  5.h,
                  variableExampleRow("fullname", "Customer Full Name", "customer"),
                  5.h,
                  variableExampleRow("spousename", "Customer Spouse Name", "your spouse"),
                  5.h,
                  variableExampleRow("user", "Current CRM user Name", ""),
                  5.h,
                  variableExampleRow("user.signature", "The Signature for the  user  sending  the email (including photo)", ""),
                  30.h,


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Save",
                        onPressed: () {
                          emailCubit.addEmailTemplate(
                            formdata: {
                              'title' : titleController.text,
                              'subject' : subjectController.text,
                              'type' : emailCubit.selectedEmailType?.type ?? "",
                              'content' : templController.text,
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