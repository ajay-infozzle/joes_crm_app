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

class SendHimEmailDialog extends StatelessWidget {
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final FocusNode subjectFocus;
  final FocusNode messageFocus;
  final VoidCallback onSend;

  const SendHimEmailDialog({
    super.key,
    required this.subjectController,
    required this.messageController,
    required this.subjectFocus,
    required this.messageFocus,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return AlertDialog(
      title: const Text(
        'Send Him Email',
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
        child: Column(
          children: [
            TextfieldTitleTextWidget(title: "Subject"),
            _buildField("Subject", subjectController, subjectFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Message"),
            _buildField("Message", messageController, messageFocus, maxline: 8),
            7.h,
          ],
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
              subjectController.clear();
              messageController.clear();
              
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

                if (subjectController.text.isNotEmpty && messageController.text.isNotEmpty) {
                  onSend();
                } else {
                  showToast(msg: "All fields are required !");
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    int maxline = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: "",
        enabled: true,
        keyboardType: TextInputType.text,
        maxline: maxline,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
