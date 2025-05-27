import 'dart:io';
import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/utils/custome_image_picker.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class TakeCustomerPhotoDialog extends StatefulWidget {
  final Function(File file) onSave;

  const TakeCustomerPhotoDialog({super.key, required this.onSave});

  @override
  State<TakeCustomerPhotoDialog> createState() => _TakeCustomerPhotoDialogState();
}

class _TakeCustomerPhotoDialogState extends State<TakeCustomerPhotoDialog> {
  File? _selectedFile;

  Future<void> _pickImage() async {
    final picked = await CustomeImagePicker.pickImageFromGallery(); 
    if (picked != null) {
      setState(() {
        _selectedFile = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Upload Customer Image',
        style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center
      ),
      contentPadding: const EdgeInsets.all(AppDimens.spacing15),
      insetPadding: const EdgeInsets.all(AppDimens.spacing15),
      backgroundColor: Colors.white,
      content: GestureDetector(
        onTap: _pickImage,
        child: Container(
          height: 150,
          margin: EdgeInsets.symmetric(vertical: AppDimens.spacing10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.greenishGrey.withAlpha(40),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _selectedFile != null
              ? Image.file(_selectedFile!, fit: BoxFit.cover)
              : const Text("Choose Image", style: TextStyle(color: Colors.black54)),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: AppColor.primary)),
        ),
        CustomButton(
          text: "Save",
          buttonHeight: AppDimens.buttonHeight45,
          buttonWidth: AppDimens.spacing90,
          onPressed: () {
            if (_selectedFile != null) {
              widget.onSave(_selectedFile!);
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
