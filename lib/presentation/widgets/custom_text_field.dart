import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:phone_form_field/phone_form_field.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final FocusNode focusNode;
  final Color? fieldBackColor;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int maxline;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    required this.focusNode,
    this.fieldBackColor,
    this.onChanged,
    this.validator,
    this.maxline = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: maxline > 1 ? AppDimens.spacing100 : AppDimens.spacing50,
      // alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: fieldBackColor ?? AppColor.greenishGrey.withValues(alpha:0.4),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColor.greenishGrey.withValues(alpha:0.4),
            offset: const Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        enabled: enabled,
        cursorColor: AppColor.primary,
        cursorWidth: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.primary.withValues(alpha:0.7),
            fontWeight: FontWeight.w400,
            fontSize: AppDimens.textSize16,
          ),
        ),
        style: TextStyle(color: AppColor.primary, fontSize: AppDimens.textSize16),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        validator: validator,
        onTapOutside: (event) => focusNode.unfocus(),
        maxLines: maxline,
      ),
    );
  }
}

class CustomPhoneField extends StatelessWidget {
  final PhoneController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final FocusNode focusNode;
  final Color? fieldBackColor;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int maxline;

  const CustomPhoneField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    required this.focusNode,
    this.fieldBackColor,
    this.onChanged,
    this.validator,
    this.maxline = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: maxline > 1 ? AppDimens.spacing100 : AppDimens.spacing50,
      // alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: fieldBackColor ?? AppColor.greenishGrey.withValues(alpha:0.4),
        borderRadius: BorderRadius.circular(AppDimens.radius16),
        boxShadow: [
          BoxShadow(
            color: AppColor.greenishGrey.withValues(alpha:0.4),
            offset: const Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: PhoneFormField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        cursorColor: AppColor.primary,
        cursorWidth: 1,
        isCountryButtonPersistent: true,
        isCountrySelectionEnabled: true,
        autofillHints: const [AutofillHints.telephoneNumber],
        style: TextStyle(color: AppColor.primary, fontSize: AppDimens.textSize16),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.primary.withValues(alpha:0.7),
            fontWeight: FontWeight.w400,
            fontSize: AppDimens.textSize16,
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(),
        textInputAction: textInputAction,
        countryButtonStyle: CountryButtonStyle(
          showFlag: true,
          showIsoCode: false,
          showDialCode: true,
          showDropdownIcon: false,
          padding: const EdgeInsets.only(right: 10, left: 10),
          textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: validator,
        // onChanged: (value) {
        //   // controller.newMobileNumber = value.countryCode + value.nsn ;
        // },
        onTapOutside: (event) => focusNode.unfocus(),
        inputFormatters: keyboardType == TextInputType.number ? [ CustomInputFormatter() ] : [],
      ),
    );
  }
}


class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    return TextEditingValue(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}