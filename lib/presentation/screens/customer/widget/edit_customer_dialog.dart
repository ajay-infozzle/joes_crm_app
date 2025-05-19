import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class EditCustomerDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController spouseNameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController wifeEmailController;
  final TextEditingController countryController;
  final TextEditingController phoneController;
  final TextEditingController wifePhoneController;
  final FocusNode nameFocus;
  final FocusNode spouseNameFocus;
  final FocusNode surnameFocus;
  final FocusNode emailFocus;
  final FocusNode wifeEmailFocus;
  final FocusNode countryFocus;
  final FocusNode phoneFocus;
  final FocusNode wifePhoneFocus;
  final VoidCallback onSave;

  const EditCustomerDialog({
    super.key,
    required this.nameController,
    required this.spouseNameController,
    required this.surnameController,
    required this.emailController,
    required this.wifeEmailController,
    required this.countryController,
    required this.phoneController,
    required this.wifePhoneController,
    required this.nameFocus,
    required this.spouseNameFocus,
    required this.surnameFocus,
    required this.emailFocus,
    required this.wifeEmailFocus,
    required this.countryFocus,
    required this.phoneFocus,
    required this.wifePhoneFocus,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return AlertDialog(
      title: const Text('Edit Customer',style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      contentPadding: EdgeInsets.all(AppDimens.spacing15),
      insetPadding: EdgeInsets.all(AppDimens.spacing15),
      surfaceTintColor: AppColor.white,
      titlePadding: EdgeInsets.all(AppDimens.spacing10),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextfieldTitleTextWidget(title: "Name"),
            _buildField("Name", nameController, nameFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Surname"),
            _buildField("Surname", surnameController, surnameFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Email"),
            _buildField("Email", emailController, emailFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Phone"),
            _buildField("Phone", phoneController, phoneFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Country"),
            _buildField("Country", countryController, countryFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Spouse Name"),
            _buildField("Spouse Name", spouseNameController, spouseNameFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Wife Email"),
            _buildField("Wife Email", wifeEmailController, wifeEmailFocus),
            7.h,

            TextfieldTitleTextWidget(title: "Wife Phone"),
            _buildField("Wife Phone", wifePhoneController, wifePhoneFocus),
            7.h,
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold)),
        ),
        CustomButton(
          text: "Save", 
          buttonHeight: AppDimens.buttonHeight45,
          buttonWidth: AppDimens.spacing90,
          fontSize: AppDimens.textSize14,
          borderRadius: AppDimens.buttonRadius16,
          onPressed: () {
            // nameFocus.unfocus();
            // surnameFocus.unfocus();
            // emailFocus.unfocus();
            // phoneFocus.unfocus();
            // countryFocus.unfocus();
            // spouseNameFocus.unfocus();
            // wifeEmailFocus.unfocus();
            // wifePhoneFocus.unfocus();
            currentFocus.unfocus();
            
            if(nameController.text.isNotEmpty || surnameController.text.isNotEmpty || emailController.text.isNotEmpty || phoneController.text.isNotEmpty || countryController.text.isNotEmpty || spouseNameController.text.isNotEmpty || wifeEmailController.text.isNotEmpty || wifePhoneController.text.isNotEmpty ){
              onSave();
              Navigator.pop(context);
            }else{
              showToast(msg: "All fields are empty !");
            }
          },
        ),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha:0.4),
        hintText: "",
        enabled: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
