import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class UsernameInputWidget extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool enabled;
  final void Function(String)? onChanged;

  const UsernameInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      enabled: enabled,
      hintText: "",
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
    );
  }
}