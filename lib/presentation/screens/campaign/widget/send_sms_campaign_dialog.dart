import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class SendSmsCampaignDialog extends StatefulWidget {
  final String title;
  final Function(Map<String, dynamic>) onSend;

  const SendSmsCampaignDialog({
    super.key,
    this.title = 'Send SMS To Client' ,
    required this.onSend,
  });

  @override
  State<SendSmsCampaignDialog> createState() => _SendSmsCampaignDialogState();
}

class _SendSmsCampaignDialogState extends State<SendSmsCampaignDialog> {
  TextEditingController fromController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode titleFocus = FocusNode();
  FocusNode fromFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(
          widget.title,
          style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.all(AppDimens.spacing15),
        insetPadding: EdgeInsets.all(AppDimens.spacing15),
        surfaceTintColor: AppColor.white,
        titlePadding: EdgeInsets.all(AppDimens.spacing10),
        elevation: 0,
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                TextfieldTitleTextWidget(title: "From"),
                _buildField("From", fromController, fromFocus),
                7.h,

                TextfieldTitleTextWidget(title: "Campaign Title"),
                _buildField("Campaign Title", titleController, titleFocus),
                7.h,
                  
                TextfieldTitleTextWidget(title: "Message"),
                _buildField("Message", messageController, messageFocus, maxline: 8),
                7.h,
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if(state is CustomerEmailSent){ 
                context.pop();
              }
            },
            builder: (context, state) {
              if(state is CustomerSendingEmail){
                return CircularProgressIndicator(
                  color: AppColor.primary, strokeWidth: 3,
                  constraints: BoxConstraints( minHeight: 30, minWidth: 30 ),
                ) ;
              }
      
              
              return CustomButton(
                text: "Send",
                buttonHeight: AppDimens.buttonHeight45,
                buttonWidth: AppDimens.spacing90,
                fontSize: AppDimens.textSize14,
                borderRadius: AppDimens.buttonRadius16,
                onPressed: () {
                  currentFocus.unfocus();

                  if (titleController.text.isEmpty || fromController.text.isEmpty || messageController.text.isEmpty) {
                    showToast(msg: "All fields are required");
                  } 
                  // if (titleController.text.isEmpty) {
                  //   showToast(msg: "Campaign title required !");
                  // } 
                  // if (subjectController.text.isEmpty) {
                  //   showToast(msg: "Subject required !");
                  // } 
                  // if (messageController.text.isEmpty) {
                  //   showToast(msg: "Message required !");
                  // } 
                  else {
                    final formadata = {
                      'title' : titleController.text,
                      'from' : fromController.text,
                      'message' : messageController.text,
                    };

                    widget.onSend(formadata);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode? focusNode, {
    int maxline = 1,
    bool enable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: "",
        enabled: enable,
        keyboardType: TextInputType.text,
        maxline: maxline,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
