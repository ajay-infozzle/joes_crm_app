import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/title_dropdown_widget.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AddLeadsScreen extends StatefulWidget {
  const AddLeadsScreen({super.key});

  @override
  State<AddLeadsScreen> createState() => _AddLeadsScreenState();
}

class _AddLeadsScreenState extends State<AddLeadsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController followDateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController saleAssocController = TextEditingController();
  PhoneController phoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.US, nsn: ''),
  );
  final TextEditingController addressController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode surnameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode followDateFocusNode = FocusNode();
  FocusNode amountFocusNode = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode salesAssocFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Add Leads",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<LeadsCubit, LeadsState>(
            listener: (context, state) {
              if(state is LeadsAddError){
                showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              }

              if(state is LeadsAdded){
                clearAllTextField();
              }
            },
            // buildWhen: (previous, current) => current is LeadsAddFormUpdate || current is LeadsAddFormLoading,
            builder: (context, state) {
              LeadsCubit leadsCubit = context.read<LeadsCubit>() ;


              if(state is LeadsAddFormLoading){
                return Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,));
              }

              return ListView(
                padding: const EdgeInsets.only(
                  top: AppDimens.spacing10,
                  left: AppDimens.spacing15,
                  right: AppDimens.spacing15,
                ),
                children: [
                  TextfieldTitleTextWidget(title: "Store"),
                  5.h,
                  StoreDropdown(
                    storeList: context.read<HomeCubit>().storeList,
                    onSelected:(selectedStore) => leadsCubit.changeStore(selectedStore),
                    initialSelected: leadsCubit.store,
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Title"),
                  5.h,
                  TitleDropdown(
                    initialSelected: leadsCubit.title,
                    onSelected: (TitleOption selected) {
                      leadsCubit.title = selected ;
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Name"),
                  _buildField("Name", nameController, nameFocusNode),
                  7.h,

                  TextfieldTitleTextWidget(title: "Surname"),
                  _buildField("Surname", surnameController, surnameFocusNode),
                  7.h,

                  TextfieldTitleTextWidget(title: "Email"),
                  _buildField("Email", emailController, emailFocusNode),
                  7.h,

                  TextfieldTitleTextWidget(title: "Phone"),
                  _buildPhoneField("Phone", phoneController, phoneFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Follow Date"),
                  GestureDetector(
                    child: _buildField(
                      "Follow Date",
                      followDateController,
                      followDateFocusNode,
                      isEnable: false,
                    ),
                    onTap: () async {
                      followDateController.text = await getDateFromUser(context);
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Amount"),
                  _buildField("Amount", amountController, amountFocusNode, inputType: TextInputType.number),
                  7.h,

                  TextfieldTitleTextWidget(title: "Address"),
                  _buildField(
                    "Address",
                    addressController,
                    addressFocus,
                    maxline: 3,
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Sales Assoc"),
                  _buildField("Sales Assoc", saleAssocController, salesAssocFocus),
                  30.h,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Add",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          leadsCubit.validateFormAndSubmit(
                            storeId: leadsCubit.store?.id ?? '', 
                            amount: amountController.text,
                            followDate: followDateController.text,
                            salesAssoc: saleAssocController.text,
                            name: nameController.text, 
                            surname: surnameController.text, 
                            email: emailController.text, 
                            phone: phoneController.value.nsn, 
                            address: addressController.text, 
                          );
                        },
                        borderRadius: AppDimens.radius16,
                        isActive: true,
                        buttonHeight: AppDimens.buttonHeight40,
                        fontSize: AppDimens.textSize18,
                      ),
                    ],
                  ),

                  30.h,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode focusNode, {
    bool isEnable = true,
    int maxline = 1,
    TextInputType inputType = TextInputType.text
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomTextField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: label,
        enabled: isEnable,
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }

  Widget _buildPhoneField(
    String label,
    PhoneController controller,
    FocusNode focusNode, {
    bool isEnable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacing6),
      child: CustomPhoneField(
        controller: controller,
        focusNode: focusNode,
        fieldBackColor: AppColor.greenishGrey.withValues(alpha: 0.4),
        hintText: label,
        enabled: isEnable,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      ),
    );
  }
  
  void clearAllTextField() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    phoneController.value = const PhoneNumber(isoCode: IsoCode.US, nsn: '');
    followDateController.clear();
    amountController.clear();
    addressController.clear();
    saleAssocController.clear();
    context.read<LeadsCubit>().store = null;
    context.read<LeadsCubit>().title = TitleOption(value: '', display: "Select title");
    context.read<LeadsCubit>().initial();
  }
}
