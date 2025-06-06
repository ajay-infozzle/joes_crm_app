// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SendApprCirtEmail extends StatefulWidget {
  final Customer customer;
  final Function(Map<String , dynamic>) onSend;
  const SendApprCirtEmail({super.key, required this.customer, required this.onSend});

  @override
  State<SendApprCirtEmail> createState() => _SendApprCirtEmailState();
}

class _SendApprCirtEmailState extends State<SendApprCirtEmail> {

  TextEditingController toEmailController = TextEditingController();
  TextEditingController salesPersonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController custNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController apprValueController = TextEditingController();

  FocusNode custNameFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode descFocus = FocusNode();
  FocusNode apprValueFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    setupInitials();
  }

  void setupInitials() {
    toEmailController.text = (widget.customer.email!.isNotEmpty ? widget.customer.email : widget.customer.wifeEmail!) ?? "" ;

    salesPersonController.text = getUser(context,  SessionManager().getUserId() ?? "");
    custNameController.text = widget.customer.name ?? '' ;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Send Appraisal Certificate Mail",
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
              TextfieldTitleTextWidget(title: "To email"),
              _buildField("To email", toEmailController, null, enable: false),
              7.h,
          
              TextfieldTitleTextWidget(title: "Sales Person"),
              _buildField("Sales Person", salesPersonController, null, enable: false),
              7.h,

              TextfieldTitleTextWidget(title: "Date"),
              GestureDetector(
                onTap: () async{
                  dateController.text = await getDateFromUser(context); 
                },
                child: _buildField("Date", dateController, null, enable: false),
              ),
              7.h,
                
              TextfieldTitleTextWidget(title: "Customer name"),
              _buildField("Customer name", custNameController, custNameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Address"),
              _buildField("Address", addressController, addressFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Description"),
              _buildField("Description", descController, descFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Appraised value"),
              _buildField("Appraised value", apprValueController, apprValueFocus),
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

        CustomButton(
          text: "Preview",
          buttonHeight: AppDimens.buttonHeight45,
          buttonWidth: AppDimens.spacing100,
          fontSize: AppDimens.textSize14,
          borderRadius: AppDimens.buttonRadius16,
          onPressed: () async{
            FocusScope.of(context).unfocus();

            final url = Uri.parse('https://joesjewelry.com/pdf-generating/appraisal-certificate-2d96a843c2f89f4764f7bd5813c16463.php?date=${dateController.text}&customer_name=${custNameController.text}&address=${addressController.text}&description=${descController.text}&appraised_value=${apprValueController.text}&sales_person=${salesPersonController.text}');
            
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              showToast(msg: "Could not open", backColor: AppColor.red);
            }
          },
        ),
        
        BlocConsumer<CustomerCubit, CustomerState>(
          listener: (context, state) {
            if(state is CustomerEmailSent){
              showAppSnackBar(context, message: "Appraisal certificate sent");
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
                FocusScope.of(context).unfocus();
                final formdata = {
                  'customer_id' : widget.customer.id,
                  'date' : dateController.text,
                  'datcustomer_name' : custNameController.text,
                  'address' : addressController.text,
                  'description' : descController.text,
                  'appraised_value' : apprValueController.text,
                };

                widget.onSend(formdata);
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
    FocusNode? focusNode, {
    int maxline = 1,
    bool enable = true,
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
        maxline: maxline,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}