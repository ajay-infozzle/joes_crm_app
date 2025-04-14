import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class UsernameInputWidget extends StatelessWidget {
  final FocusNode focusNode = FocusNode();
  UsernameInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "",
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }
}