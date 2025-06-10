import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/widget/follow_up_dropdown.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class FolloUpDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  const FolloUpDialog({super.key, required this.onSave});

  @override
  State<FolloUpDialog> createState() => _FolloUpDialogState();
}

class _FolloUpDialogState extends State<FolloUpDialog> {

  FollowUpOption? option ;
  bool showFollowUpDate = false;
  bool showResonText = false;

  TextEditingController reasonCont = TextEditingController();  
  TextEditingController nextFollowUpDateCont = TextEditingController(); 
  
  FocusNode reasonFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Save Follow-up Results',
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
              TextfieldTitleTextWidget(title: "Result"),
              5.h,
              FollowUpDropdown(
                onSelected:(selected) {
                    option = selected ;
                    setState(() {
                      if(selected.value == 'reschedule'){
                      showFollowUpDate = true;
                      showResonText = false;
                    }
                    if(selected.value == 'dead_pending'){
                      showFollowUpDate = false;
                      showResonText = true;
                    }
                  });
                }, 
                initialSelected: FollowUpOption(value: '', display: ''),
              ),
              12.h,

              if(showFollowUpDate)
              Column(
                children: [
                  TextfieldTitleTextWidget(title: "Next Follo-up"),
                  GestureDetector(
                    onTap: () async{
                      nextFollowUpDateCont.text = await getDateFromUser(context);
                    },
                    child: _buildField("Next Follo-up", nextFollowUpDateCont, null, isEnable: false),
                  ),
                  7.h,
                ],
              ),
              
              if(showResonText)
              Column(
                children: [
                  TextfieldTitleTextWidget(title: "Reason"),
                  _buildField("reason", reasonCont, reasonFocus), 
                  7.h,
                ],
              ),

              10.h,
            ],
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomButton(
          text: "Search",
          buttonHeight: AppDimens.buttonHeight45,
          buttonWidth: AppDimens.spacing90,
          fontSize: AppDimens.textSize14,
          borderRadius: AppDimens.buttonRadius16,
          onPressed: () {
            
            FocusScope.of(context).unfocus();

            if(option == null || option?.value == ''){
              showToast(msg: "Please select result", backColor: AppColor.red);
              return ;
            }

            final formdata = {
              'result' : option!.value,
              'follow_date' : nextFollowUpDateCont.text,
              'dead_reason' : reasonCont.text
            } ;

            context.pop();

            widget.onSave(formdata);
          },
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode? focusNode, {
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
}