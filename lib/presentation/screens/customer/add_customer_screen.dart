import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/origination_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/radio_box_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';
import 'package:phone_form_field/phone_form_field.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  PhoneController phoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.US, nsn: ''),
  );
  final TextEditingController spouseNameController = TextEditingController();
  final TextEditingController wifeEmailController = TextEditingController();
  PhoneController wifePhoneController = PhoneController(
    initialValue: const PhoneNumber(isoCode: IsoCode.US, nsn: ''),
  );
  final TextEditingController birthController = TextEditingController();
  final TextEditingController spouseBirthController = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode surnameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode spouseNameFocus = FocusNode();
  final FocusNode wifeEmailFocus = FocusNode();
  final FocusNode wifePhoneFocus = FocusNode();
  final FocusNode birthFocus = FocusNode();
  final FocusNode spouseBirthFocus = FocusNode();
  final FocusNode anniversaryFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode zipFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();


  @override
  void initState() {
    super.initState();

    if(context.read<CustomerCubit>().tempCustGender == 'M'){
      emailController.text = context.read<CustomerCubit>().tempCustEmail;
    }else{
      wifeEmailController.text = context.read<CustomerCubit>().tempCustEmail;
    }
   context.read<CustomerCubit>().currentPickedImg = null ;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: Text(
          "Add Customer",
          style: TextStyle(
            fontSize: AppDimens.textSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<CustomerCubit, CustomerState>(
          listener: (context, state) {
            if(state is CustomerAddError){
              showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
            }
            if(state is CustomerAddFormSubmitted){
              context.pop();
            }
          },
          buildWhen: (previous, current) => current is CustomerAddFormUpdate || current is CustomerAddFormLoading,
          builder: (context, state) {
            CustomerCubit customerCubit = context.read<CustomerCubit>() ;

            if(state is CustomerAddFormLoading){
              return Container(
                width: double.maxFinite,
                color: AppColor.white,
                child: Center(child: CircularProgressIndicator(color: AppColor.backgroundColor,),)
              );
            }

            return Container(
              width: double.maxFinite,
              color: AppColor.white,
              child: ListView(
                padding: const EdgeInsets.only(
                  top: AppDimens.spacing10,
                  left: AppDimens.spacing15,
                  right: AppDimens.spacing15,
                ),
                children: [
                  TextfieldTitleTextWidget(title: "Store", isMandatory: true,),
                  5.h,
                  StoreDropdown(
                    storeList: context.read<HomeCubit>().storeList, 
                    onSelected: (selectedStore) => customerCubit.changeStore(selectedStore),
                    initialSelected: customerCubit.store,
                  ),
                  10.h,

                  TextfieldTitleTextWidget(title: "His Name"),
                  _buildField("His Name", nameController, nameFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Her Name"),
                  _buildField("Her Name",spouseNameController,spouseNameFocus,),
                  7.h,

                  TextfieldTitleTextWidget(title: "Surname"),
                  _buildField("Surname", surnameController, surnameFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "His Email"),
                  _buildField(
                    "His Email", emailController, emailFocus, 
                    isEnable: customerCubit.tempCustGender == 'M' ? false : true
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Her Email"),
                  _buildField(
                    "Her Email",wifeEmailController,wifeEmailFocus,
                    isEnable: customerCubit.tempCustGender == 'F' ? false : true
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Photo"),
                  GestureDetector(
                    onTap: () => context.read<CustomerCubit>().pickImage(),
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
                      child: context.read<CustomerCubit>().currentPickedImg != null
                          ? Image.file(context.read<CustomerCubit>().currentPickedImg!, fit: BoxFit.cover)
                          : const Text("Choose Image", style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "His cell number"),
                  _buildPhoneField("His cell number", phoneController, phoneFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Her cell number"),
                  _buildPhoneField("Her cell number",wifePhoneController,wifePhoneFocus,),
                  7.h,

                  TextfieldTitleTextWidget(title: "His Birthday"),
                  GestureDetector(
                    child: _buildField(
                      "His Birthday",
                      birthController,
                      birthFocus,
                      isEnable: false,
                    ),
                    onTap: () async {
                      birthController.text = await getDateFromUser(context);
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Her Birthday"),
                  GestureDetector(
                    child: _buildField(
                      "Her Birthday",
                      spouseBirthController,
                      spouseBirthFocus,
                      isEnable: false,
                    ),
                    onTap: () async {
                      spouseBirthController.text = await getDateFromUser(
                        context,
                      );
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Anniversary"),
                  GestureDetector(
                    child: _buildField(
                      "Anniversary",
                      anniversaryController,
                      anniversaryFocus,
                      isEnable: false,
                    ),
                    onTap: () async {
                      anniversaryController.text = await getDateFromUser(
                        context,
                      );
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Vip"),
                  7.h,
                  Row(
                    children: [
                      RadioBoxButton(
                        text: 'Yes',
                        groupValue: customerCubit.vip,
                        value: 'Yes',
                        onChanged: (value) => customerCubit.changeVip(value!),
                      ),
                      10.w,
                      RadioBoxButton(
                        text: 'No',
                        groupValue: customerCubit.vip,
                        value: 'No',
                        onChanged: (value) => customerCubit.changeVip(value!),
                      ),
                    ],
                  ),
                  10.h,

                  TextfieldTitleTextWidget(title: "Origination"),
                  5.h,
                  OriginationDropdown(
                    initialSelected: customerCubit.origination,
                    onSelected: (OriginationOption selected) {
                      customerCubit.origination = selected ;
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Address"),
                  _buildField(
                    "Address",
                    addressController,
                    addressFocus,
                    maxline: 3,
                  ),
                  7.h,

                  CSCPickerPlus(
                    layout: Layout.vertical,
                    countryDropdownLabel: "Country",
                    stateDropdownLabel: "State",
                    cityDropdownLabel: "City",
                    selectedItemStyle: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize16,
                    ),
                    currentCountry: customerCubit.country.isEmpty ? null : customerCubit.country,
                    currentState: customerCubit.statte.isEmpty ? null : customerCubit.statte,
                    currentCity: customerCubit.city.isEmpty ? null : customerCubit.city,
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
                  ),
                  12.h,

                  TextfieldTitleTextWidget(title: "Zip"),
                  _buildField("Zip", zipController, zipFocus, inputType: TextInputType.number),
                  7.h,

                  TextfieldTitleTextWidget(title: "Notes"),
                  _buildField(
                    "Notes",
                    notesController,
                    notesFocus,
                    maxline: 7,
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Unsubscribe from emails"),
                  7.h,
                  Row(
                    children: [
                      RadioBoxButton(
                        text: 'Yes',
                        groupValue: customerCubit.subscribe,
                        value: 'Yes',
                        onChanged: (value) => customerCubit.changeSubscribe(value!),
                      ),
                      10.w,
                      RadioBoxButton(
                        text: 'No',
                        groupValue: customerCubit.subscribe,
                        value: 'No',
                        onChanged: (value) => customerCubit.changeSubscribe(value!),
                      ),
                    ],
                  ),
                  30.h,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Save",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          customerCubit.validateFormAndSubmit(
                            storeId: customerCubit.store?.id ?? '', 
                            name: nameController.text, 
                            surname: surnameController.text, 
                            email: emailController.text, 
                            phone: phoneController.value.nsn, 
                            cntry: customerCubit.checkCountry(), 
                            spouseName: spouseNameController.text, 
                            wifeEmail: wifeEmailController.text, 
                            wifePhone: wifePhoneController.value.nsn, 
                            ship: customerCubit.origination.value, 
                            vip: customerCubit.vip == "No"? "0" : "1", 
                            address: addressController.text, 
                            city: customerCubit.city, 
                            sstate: customerCubit.statte, 
                            zip: zipController.text, 
                            birthday: birthController.text, 
                            wifeBirthday: spouseBirthController.text, 
                            anniversary: anniversaryController.text, 
                            unsubscribe: customerCubit.subscribe == "No"? "0" : "1",
                            notes: notesController.text
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
              ),
            );
          },
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
}
