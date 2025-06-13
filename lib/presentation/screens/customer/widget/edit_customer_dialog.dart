import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/data/model/single_customer_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/origination_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/radio_box_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class EditCustomerDialog extends StatefulWidget {
  final Customer customer;
  final Function(Map<String, dynamic>) onSave;

  const EditCustomerDialog({
    super.key,
    required this.customer,
    required this.onSave,
  });

  @override
  State<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  final nameController = TextEditingController();
  final spouseNameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final wifeEmailController = TextEditingController();
  final notesController = TextEditingController();
  // final countryController = TextEditingController(text: customer.country ?? '');
  final phoneController = TextEditingController();
  final wifePhoneController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  final birthController = TextEditingController();
  final spouseBirthController = TextEditingController();
  final anniversaryController = TextEditingController();

  final nameFocus = FocusNode();
  final spouseNameFocus = FocusNode();
  final surnameFocus = FocusNode();
  final emailFocus = FocusNode();
  final wifeEmailFocus = FocusNode();
  final countryFocus = FocusNode();
  final phoneFocus = FocusNode();
  final wifePhoneFocus = FocusNode();
  final notesFocus = FocusNode();
  final addressFocus = FocusNode();
  final zipFocus = FocusNode();
  final birthFocus = FocusNode();
  final spouseBirthFocus = FocusNode();
  final anniversaryFocus = FocusNode();
  String country = '';
  String state = '';
  String city = '';
  Stores? currentStore;
  String vip = "No";
  String subscribe = "No";
  OriginationOption origination = OriginationOption(
    value: '',
    display: 'Select origination',
  ); //ship, hotel, mailchimp, NotAvailable

  @override
  void initState() {
    super.initState();

    nameController.text = widget.customer.name ?? '';
    surnameController.text = widget.customer.surname ?? '';
    emailController.text = widget.customer.email ?? '';
    wifeEmailController.text = widget.customer.wifeEmail ?? '';
    notesController.text = widget.customer.notes ?? '';
    phoneController.text = widget.customer.phone ?? '';
    wifePhoneController.text = widget.customer.wifePhone ?? '';
    currentStore = getStoreByNameObj(context, widget.customer.store ?? '');

    country = context.read<CustomerCubit>().getCountry(
      widget.customer.country ?? "",
    );
    // vip = widget.customer.vip
    // subscribe = widget.customer.subscribe
    // origination = widget.customer.origination
    // addressController.text = widget.customer.address
    // state = widget.customer.state
    // city = widget.customer.city
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return AlertDialog(
      title: const Text(
        'Edit Customer',
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
              TextfieldTitleTextWidget(title: "Store"),
              5.h,
              StoreDropdown(
                storeList: context.read<HomeCubit>().storeList,
                onSelected:
                    (selectedStore) => setState(() {
                      currentStore = selectedStore;
                    }),
                initialSelected: currentStore,
              ),
              10.h,

              TextfieldTitleTextWidget(title: "His name"),
              _buildField("His name", nameController, nameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Her name"),
              _buildField("Her name", spouseNameController, spouseNameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Surname"),
              _buildField("Surname", surnameController, surnameFocus),
              7.h,

              TextfieldTitleTextWidget(title: "His email"),
              _buildField(
                "His email",
                emailController,
                emailFocus,
                // enable: emailController.text.isNotEmpty ? false : true,
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Her email"),
              _buildField(
                "Her email",
                wifeEmailController,
                wifeEmailFocus,
                // enable: wifeEmailController.text.isNotEmpty ? false : true,
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Vip"),
              7.h,
              Row(
                children: [
                  RadioBoxButton(
                    text: 'Yes',
                    groupValue: vip,
                    value: 'Yes',
                    onChanged:
                        (value) => setState(() {
                          vip = value!;
                        }),
                  ),
                  10.w,
                  RadioBoxButton(
                    text: 'No',
                    groupValue: vip,
                    value: 'No',
                    onChanged:
                        (value) => setState(() {
                          vip = value!;
                        }),
                  ),
                ],
              ),
              10.h,

              TextfieldTitleTextWidget(title: "Origination"),
              5.h,
              OriginationDropdown(
                initialSelected: origination,
                onSelected: (OriginationOption selected) {
                  setState(() {
                    origination = selected;
                  });
                },
              ),
              7.h,

              TextfieldTitleTextWidget(title: "His cell number"),
              _buildField("His cell number", phoneController, phoneFocus),
              7.h,

              TextfieldTitleTextWidget(title: "Her cell number"),
              _buildField(
                "Her cell number",
                wifePhoneController,
                wifePhoneFocus,
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

              // TextfieldTitleTextWidget(title: "Country"),
              // _buildField("Country", countryController, countryFocus),
              // 7.h,
              CSCPickerPlus(
                layout: Layout.vertical,
                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",
                selectedItemStyle: TextStyle(
                  color: AppColor.primary,
                  fontSize: AppDimens.textSize16,
                ),
                currentCountry: country.isEmpty ? null : country,
                currentState: state.isEmpty ? null : state,
                currentCity: city.isEmpty ? null : city,
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
                    // customerCubit.changeCountry(contry.trim().split("    ")[1]);
                    setState(() {
                      country = contry.trim().split("    ")[1];
                    });
                  }
                },
                onStateChanged: (ste) {
                  if (ste != null && ste.isNotEmpty) {
                    // customerCubit.changeState(ste);
                    setState(() {
                      state = ste;
                    });
                  }
                },
                onCityChanged: (cty) {
                  if (cty != null && cty.isNotEmpty) {
                    // customerCubit.changeCity(cty);
                    setState(() {
                      city = cty;
                    });
                  }
                },
              ),
              7.h,

              TextfieldTitleTextWidget(title: "His Birthday"),
              GestureDetector(
                child: _buildField(
                  "His Birthday",
                  birthController,
                  birthFocus,
                  enable: false,
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
                  enable: false,
                ),
                onTap: () async {
                  spouseBirthController.text = await getDateFromUser(context);
                },
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Anniversary"),
              GestureDetector(
                child: _buildField(
                  "Anniversary",
                  anniversaryController,
                  anniversaryFocus,
                  enable: false,
                ),
                onTap: () async {
                  anniversaryController.text = await getDateFromUser(context);
                },
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Zip"),
              _buildField(
                "Zip",
                zipController,
                zipFocus,
                inputType: TextInputType.number,
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Notes"),
              _buildField("Notes", notesController, notesFocus, maxline: 7),
              7.h,

              TextfieldTitleTextWidget(title: "Unsubscribe from emails"),
              7.h,
              Row(
                children: [
                  RadioBoxButton(
                    text: 'Yes',
                    groupValue: subscribe,
                    value: 'Yes',
                    onChanged:
                        (value) => setState(() {
                          subscribe = value!;
                        }),
                  ),
                  10.w,
                  RadioBoxButton(
                    text: 'No',
                    groupValue: subscribe,
                    value: 'No',
                    onChanged:
                        (value) => setState(() {
                          subscribe = value!;
                        }),
                  ),
                ],
              ),
              30.h,
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
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
                currentFocus.unfocus();

                final formdata = {
                  'id' : widget.customer.id ,
                  'store_id': currentStore?.id ?? '',
                  'email': emailController.text,
                  'country': country,
                  'name': nameController.text,
                  'surname': surnameController.text,
                  'spouse_name': spouseNameController.text,
                  'wife_email': wifeEmailController.text,
                  'vip': vip == "No" ? "0" : "1",
                  'ship': origination.value,
                  'address': addressController.text,
                  'city': city,
                  'state': state,
                  'zip': zipController.text,
                  'phone': phoneController.text,
                  'wife_phone': wifePhoneController.text,
                  'birthday': birthController.text,
                  'spouse_birthday': spouseBirthController.text,
                  'anniversary': anniversaryController.text,
                  'unsubscribed': subscribe == "No" ? "0" : "1",
                  'notes': notesController.text,
                };

                // if (nameController.text.isNotEmpty ||
                //     surnameController.text.isNotEmpty ||
                //     emailController.text.isNotEmpty ||
                //     phoneController.text.isNotEmpty ||
                //     spouseNameController.text.isNotEmpty ||
                //     country.isNotEmpty ||
                //     wifeEmailController.text.isNotEmpty ||
                //     wifePhoneController.text.isNotEmpty) {

                // } else {
                //   showToast(msg: "All field are empty !");
                // }

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
