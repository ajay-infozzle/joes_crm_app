import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

class SendWaterTaxiEmailDialog extends StatefulWidget {
  final String toEmail;
  final Function(Map<String, dynamic> formdata) onSend;

  const SendWaterTaxiEmailDialog({
    super.key,
    required this.toEmail,
    required this.onSend,
  });

  @override
  State<SendWaterTaxiEmailDialog> createState() =>
      _SendWaterTaxiEmailDialogState();
}

class _SendWaterTaxiEmailDialogState extends State<SendWaterTaxiEmailDialog> {
  // final TextEditingController codeController = TextEditingController();
  final TextEditingController currentDateController = TextEditingController();
  final TextEditingController expireDateController = TextEditingController();
  // final TextEditingController salesPersonController = TextEditingController();
  final TextEditingController shipNameController = TextEditingController();
  final TextEditingController rideCountController = TextEditingController();

  final FocusNode currentDateFocus = FocusNode();
  final FocusNode expireDateFocus = FocusNode();
  final FocusNode shipNameFocus = FocusNode();
  final FocusNode rideCountFocus = FocusNode();

  final List<TextEditingController> customerControllers = [];
  final List<FocusNode> customerFocus = [];

  @override
  void initState() {
    super.initState();
    currentDateController.text = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now());
    customerControllers.add(TextEditingController());
    customerFocus.add(FocusNode());
  }

  @override
  void dispose() {
    // codeController.dispose();
    currentDateController.dispose();
    expireDateController.dispose();
    // salesPersonController.dispose();
    shipNameController.dispose();
    rideCountController.dispose();
    for (var c in customerControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addCustomerField() {
    setState(() {
      customerControllers.add(TextEditingController());
      customerFocus.add(FocusNode());
    });
  }

  void _removeCustomerField(int index) {
    if (customerControllers.length > 1) {
      setState(() {
        customerControllers.removeAt(index);
        customerFocus.removeAt(index);
      });
    }
  }

  Map<String, dynamic> getFormData() {
    final expireDate = expireDateController.text.trim();
    final shipName = shipNameController.text.trim();
    final rideCount = rideCountController.text.trim();
    final customerNames = customerControllers
        .map((c) => c.text.trim())
        .where((name) => name.isNotEmpty)
        .join(',');

    return {
      'expire_date': expireDate,
      'customer_name': customerNames,
      'ship_name': shipName,
      'ride_count': rideCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text(
          "Send Water Taxi Email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primary,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.all(AppDimens.spacing15),
        insetPadding: const EdgeInsets.all(AppDimens.spacing15),
        surfaceTintColor: AppColor.white,
        titlePadding: const EdgeInsets.all(AppDimens.spacing10),
        elevation: 0,
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                _labelAndField(
                  "To email",
                  TextEditingController(text: widget.toEmail),
                  FocusNode(),
                  enabled: false,
                ),
                // _labelAndField("Code", codeController),
                _labelAndField(
                  "Current Date",
                  currentDateController,
                  currentDateFocus,
                  enabled: false,
                ),
                GestureDetector(
                  onTap: () async {
                    expireDateController.text = await getDateFromUser(context);
                  },
                  child: _labelAndField(
                    "Expire Date",
                    expireDateController,
                    expireDateFocus,
                    enabled: false,
                  ),
                ),
                _buildDynamicCustomerFields(),
                // _labelAndField("Sales Person", salesPersonController),
                _labelAndField("Ship Name", shipNameController, shipNameFocus),
                _labelAndField(
                  "Ride Count",
                  rideCountController,
                  rideCountFocus,
                  textInputType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if(state is CustomerEmailSent){
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
                  currentFocus.unfocus();

                  if (customerControllers.any((c) => c.text.isEmpty)) {
                    showToast(msg: "Customer name is required");
                    return;
                  }
                  if (expireDateController.text.isEmpty) {
                    showToast(msg: "Expire date is required");
                    return;
                  }
                  if (shipNameController.text.isEmpty) {
                    showToast(msg: "Ship name is required");
                    return;
                  }
                  if (rideCountController.text.isEmpty) {
                    showToast(msg: "Ride count is required");
                    return;
                  }

                  final formData = getFormData();
                  widget.onSend(formData);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _labelAndField(
    String label,
    TextEditingController controller,
    FocusNode focus, {
    bool enabled = true,
    TextInputType textInputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextfieldTitleTextWidget(title: label),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing5),
          child: CustomTextField(
            controller: controller,
            hintText: "",
            enabled: enabled,
            fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
            focusNode: focus,
            keyboardType: textInputType,
          ),
        ),
        7.h,
      ],
    );
  }

  Widget _buildDynamicCustomerFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextfieldTitleTextWidget(title: "Customer Name"),
        ...List.generate(customerControllers.length, (index) {
          final isLast = index == customerControllers.length - 1;
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.spacing5,
                  ),
                  child: CustomTextField(
                    controller: customerControllers[index],
                    hintText: "Enter name",
                    fieldBackColor: AppColor.greenishGrey.withValues(
                      alpha: 0.4,
                    ),
                    focusNode: customerFocus[index],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  isLast ? Icons.add : Icons.remove,
                  color: AppColor.primary,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  isLast ? _addCustomerField() : _removeCustomerField(index);
                },
              ),
            ],
          );
        }),
        7.h,
      ],
    );
  }
}
