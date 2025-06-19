import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class TakeRecieptPdfDialog extends StatefulWidget {
  final Function(FilePickerResult file) onSave;

  const TakeRecieptPdfDialog({super.key, required this.onSave});

  @override
  State<TakeRecieptPdfDialog> createState() => _TakeRecieptPdfDialogState();
}

class _TakeRecieptPdfDialogState extends State<TakeRecieptPdfDialog> {
  FilePickerResult? _selectedFile;

  Future<void> _pickPdf() async {
    final picked = await CustomeImagePicker.pickPdfFile();
    if (picked != null) {
      setState(() {
        _selectedFile = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text(
          'Upload Receipt PDF',
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
            fontSize: AppDimens.textSize20,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.all(AppDimens.spacing15),
        insetPadding: const EdgeInsets.all(AppDimens.spacing15),
        backgroundColor: Colors.white,
        content: GestureDetector(
          onTap: _pickPdf,
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: AppDimens.spacing10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColor.greenishGrey.withAlpha(40),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            alignment: Alignment.center,
            child:
                _selectedFile != null
                    ? Text(
                      _selectedFile!.files.single.name,
                      style: TextStyle(color: Colors.black),
                    )
                    : const Text(
                      "Choose Pdf",
                      style: TextStyle(color: Colors.black54),
                    ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColor.primary),
            ),
          ),

          BlocConsumer<SaleCubit, SaleState>(
            listener: (context, state) {
              if(state is SaleFormError){
                showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              }

              if(state is SaleFormSaved){
                context.pop();
              }
            },
            builder: (context, state) {
              if(state is SaleFormLoading){
                return Container(
                  width: double.maxFinite,
                  color: AppColor.white,
                  child: Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,),)
                );
              }

              return CustomButton(
                text: "Save",
                buttonHeight: AppDimens.buttonHeight45,
                buttonWidth: AppDimens.spacing90,
                onPressed: () {
                  if (_selectedFile != null) {
                    widget.onSave(_selectedFile!);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
