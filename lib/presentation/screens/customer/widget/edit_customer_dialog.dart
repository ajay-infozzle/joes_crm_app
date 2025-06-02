import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
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
  // final TextEditingController countryController;
  final TextEditingController phoneController;
  final TextEditingController wifePhoneController;
  final TextEditingController notesController;
  final FocusNode nameFocus;
  final FocusNode spouseNameFocus;
  final FocusNode surnameFocus;
  final FocusNode emailFocus;
  final FocusNode wifeEmailFocus;
  final FocusNode countryFocus;
  final FocusNode phoneFocus;
  final FocusNode wifePhoneFocus;
  final FocusNode notesFocus;
  final VoidCallback onSave;

  const EditCustomerDialog({
    super.key,
    required this.nameController,
    required this.spouseNameController,
    required this.surnameController,
    required this.emailController,
    required this.wifeEmailController,
    // required this.countryController,
    required this.phoneController,
    required this.wifePhoneController,
    required this.notesController,
    required this.nameFocus,
    required this.spouseNameFocus,
    required this.surnameFocus,
    required this.emailFocus,
    required this.wifeEmailFocus,
    required this.countryFocus,
    required this.phoneFocus,
    required this.wifePhoneFocus,
    required this.notesFocus,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return AlertDialog(
      title: const Text(
        'Edit Customer',
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
              TextfieldTitleTextWidget(title: "His name"),
              _buildField("His name", nameController, nameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Her name"),
              _buildField("Her name", spouseNameController, spouseNameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Surname"),
              _buildField("Surname", surnameController, surnameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "His email"),
              _buildField(
                "His email",
                emailController,
                emailFocus,
                enable: emailController.text.isNotEmpty ? false : true,
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Her email"),
              _buildField(
                "Her email",
                wifeEmailController,
                wifeEmailFocus,
                enable: wifeEmailController.text.isNotEmpty ? false : true,
              ),
              7.h,

              TextfieldTitleTextWidget(title: "His cell number"),
              _buildField("His cell number", phoneController, phoneFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Her cell number"),
              _buildField(
                "Her cell number",
                wifePhoneController,
                wifePhoneFocus,
              ),
              7.h,

              // TextfieldTitleTextWidget(title: "Country"),
              // _buildField("Country", countryController, countryFocus),
              // 7.h,

              BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  CustomerCubit customerCubit = context.read<CustomerCubit>();

                  return CSCPickerPlus(
                    layout: Layout.vertical,
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",
                    selectedItemStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize16,
                    ),
                    currentCountry:
                        customerCubit.country.isEmpty
                            ? null
                            : customerCubit.country,
                    currentState:
                        customerCubit.statte.isEmpty
                            ? null
                            : customerCubit.statte,
                    currentCity:
                        customerCubit.city.isEmpty ? null : customerCubit.city,
                    disabledDropdownDecoration: BoxDecoration(
                      color: AppColor.greenishGrey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppDimens.radius16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.greenishGrey.withValues(alpha: 0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),

                    dropdownDecoration: BoxDecoration(
                      color: AppColor.greenishGrey.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppDimens.radius16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.greenishGrey.withValues(alpha: 0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),

                    onCountryChanged: (contry) {
                      if (contry.isNotEmpty) {
                        customerCubit.changeCountry(contry);
                      }
                    },
                    onStateChanged: (ste) {
                      if (ste != null && ste.isNotEmpty) {
                        customerCubit.changeState(ste);
                      }
                    },
                    onCityChanged: (cty) {
                      if (cty != null && cty.isNotEmpty) {
                        customerCubit.changeCity(cty);
                      }
                    },
                  );
                },
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Notes"),
              _buildField(
                "Notes",
                notesController,
                notesFocus,
                maxline: 7,
              ),
              12.h,
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

            if (nameController.text.isNotEmpty ||
                surnameController.text.isNotEmpty ||
                emailController.text.isNotEmpty ||
                phoneController.text.isNotEmpty ||
                spouseNameController.text.isNotEmpty ||
                context.read<CustomerCubit>().country.isNotEmpty ||
                wifeEmailController.text.isNotEmpty ||
                wifePhoneController.text.isNotEmpty) {
              onSave();
              Navigator.pop(context);
            } else {
              showToast(msg: "All field are empty !");
            }
          },
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    bool enable = true,
    int maxline = 1
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
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }
}
