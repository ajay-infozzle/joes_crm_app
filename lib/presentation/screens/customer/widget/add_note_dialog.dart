import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class AddNoteDialog extends StatefulWidget {
  final Customer customer;
  final Function(Map<String, dynamic>) onSave;
  const AddNoteDialog({super.key, required this.customer, required this.onSave});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  
  final noteController = TextEditingController();
  final noteFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Note',
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
              TextfieldTitleTextWidget(title: "Notes"),
              _buildField("Notes", noteController, noteFocus, maxline: 7),
              7.h,
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

        BlocConsumer<CustomerCubit, CustomerState>(
          listener: (context, state) {
            if(state is CustomerUpdated){
              context.pop();
            }
            if(state is CustomerUpdateFormError){
              showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            if(state is CustomerUpdateFormLoading){
              return CircularProgressIndicator(
                color: AppColor.primary,
              );
            }

            return CustomButton(
              text: "Save",
              buttonHeight: AppDimens.buttonHeight45,
              buttonWidth: AppDimens.spacing90,
              fontSize: AppDimens.textSize14,
              borderRadius: AppDimens.buttonRadius16,
              onPressed: () {
                FocusScope.of(context).unfocus();

                if(noteController.text.trim().isEmpty){
                  showToast(msg: "Please enter a note");
                  return;
                }

                final formdata = {
                  'customer_id' : widget.customer.id ,
                  'add_notes' : noteController.text.trim(),
                };

                widget.onSave(formdata);
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
    bool enable = true,
    int maxline = 1,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: "",
        enabled: enable,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }
}