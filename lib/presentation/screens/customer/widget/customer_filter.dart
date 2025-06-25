import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/origination_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/radio_box_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class CustomerFilter extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearch;
  const CustomerFilter({super.key, required this.onSearch});

  @override
  State<CustomerFilter> createState() => _CustomerFilterState();
}

class _CustomerFilterState extends State<CustomerFilter> {

  Stores? storeSelected ;
  String unsubscribed = 'No';
  String vip = 'No';
  String addressVerified = 'No';
  String hasAniversary = 'No';
  String hasBirthday = 'No';
  OriginationOption  origination = OriginationOption(value: '', display: 'Select origination');

  TextEditingController salesFromCont = TextEditingController(); 
  TextEditingController salesToCont = TextEditingController(); 
  TextEditingController salesFromDateCont = TextEditingController(); 
  TextEditingController salesToDateCont = TextEditingController(); 
  TextEditingController birthFromDateCont = TextEditingController(); 
  TextEditingController birthToDateCont = TextEditingController(); 
  TextEditingController anniversaryFromDateCont = TextEditingController(); 
  TextEditingController anniversaryToDateCont = TextEditingController(); 

  FocusNode salesFromFocus = FocusNode();
  FocusNode salesToFocus = FocusNode();

  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Filter',
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
                onSelected: (selectedStore) => setState(() {
                  storeSelected = selectedStore ;
                }),
                initialSelected: storeSelected,
              ),
              12.h,

              TextfieldTitleTextWidget(title: "Origination"),
              5.h,
              OriginationDropdown(
                initialSelected: origination,
                onSelected: (OriginationOption selected) {
                  origination = selected ;
                },
              ),
              12.h,
              
              TextfieldTitleTextWidget(title: "Sales from"),
              _buildField("Sales from",salesFromCont, salesFromFocus,),
              7.h,

              TextfieldTitleTextWidget(title: "Sales to"),
              _buildField("Sales to",salesToCont, salesToFocus,),
              7.h,

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Sales from date"),
                        GestureDetector(
                          child: _buildField(
                            "Sales from",
                            salesFromDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            salesFromDateCont.text = getDMY(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                  10.w,
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Sales to date"),
                        GestureDetector(
                          child: _buildField(
                            "Sales to",
                            salesToDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            salesToDateCont.text = getDMY(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                ],
              ),
              7.h,

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Birthday from"),
                        GestureDetector(
                          child: _buildField(
                            "Birthday from",
                            birthFromDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            birthFromDateCont.text = getDM(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                  10.w,
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Birthday to"),
                        GestureDetector(
                          child: _buildField(
                            "Birthday to",
                            birthToDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            birthToDateCont.text = getDM(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                ],
              ),
              7.h,

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Anniversary from"),
                        GestureDetector(
                          child: _buildField(
                            "Anniversary from",
                            anniversaryFromDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            anniversaryFromDateCont.text = getDM(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                  10.w,
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Anniversary to"),
                        GestureDetector(
                          child: _buildField(
                            "Anniversary to",
                            anniversaryToDateCont,
                            null,
                            isEnable: false,
                          ),
                          onTap: () async {
                            anniversaryToDateCont.text = getDM(await getDateFromUser(context));
                          },
                        ),
                      ],
                    )  
                  ),
                ],
              ),
              7.h,

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Has Birthday"),
                        7.h,
                        Row(
                          children: [
                            RadioBoxButton(
                              text: 'Yes',
                              groupValue: hasBirthday,
                              value: 'Yes',
                              onChanged: (value) => setState(() {
                                hasBirthday = value! ;
                              }),
                            ),
                            10.w,
                            RadioBoxButton(
                              text: 'No',
                              groupValue: hasBirthday,
                              value: 'No',
                              onChanged: (value) => setState(() {
                                hasBirthday = value! ;
                              }),
                            ),
                          ],
                        ),
                      ],
                    )  
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Has Anniversary"),
                        7.h,
                        Row(
                          children: [
                            RadioBoxButton(
                              text: 'Yes',
                              groupValue: hasAniversary,
                              value: 'Yes',
                              onChanged: (value) => setState(() {
                                hasAniversary = value! ;
                              }),
                            ),
                            10.w,
                            RadioBoxButton(
                              text: 'No',
                              groupValue: hasAniversary,
                              value: 'No',
                              onChanged: (value) => setState(() {
                                hasAniversary = value! ;
                              }),
                            ),
                          ],
                        ),
                      ],
                    )  
                  ),
                ],
              ),
              8.h,

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Vip"),
                        7.h,
                        Row(
                          children: [
                            RadioBoxButton(
                              text: 'Yes',
                              groupValue: vip,
                              value: 'Yes',
                              onChanged: (value) => setState(() {
                                vip = value! ;
                              }),
                            ),
                            10.w,
                            RadioBoxButton(
                              text: 'No',
                              groupValue: vip,
                              value: 'No',
                              onChanged: (value) => setState(() {
                                vip = value! ;
                              }),
                            ),
                          ],
                        ),
                      ],
                    )  
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Unsubscribed"),
                        7.h,
                        Row(
                          children: [
                            RadioBoxButton(
                              text: 'Yes',
                              groupValue: unsubscribed,
                              value: 'Yes',
                              onChanged: (value) => setState(() {
                                unsubscribed = value! ;
                              }),
                            ),
                            10.w,
                            RadioBoxButton(
                              text: 'No',
                              groupValue: unsubscribed,
                              value: 'No',
                              onChanged: (value) => setState(() {
                                unsubscribed = value! ;
                              }),
                            ),
                          ],
                        ),
                      ],
                    )  
                  ),
                ],
              ),
              8.h,

              TextfieldTitleTextWidget(title: "Address verified"),
              7.h,
              Row(
                children: [
                  RadioBoxButton(
                    text: 'Yes',
                    groupValue: addressVerified,
                    value: 'Yes',
                    onChanged: (value) => setState(() {
                      addressVerified = value! ;
                    }),
                  ),
                  10.w,
                  RadioBoxButton(
                    text: 'No',
                    groupValue: addressVerified,
                    value: 'No',
                    onChanged: (value) => setState(() {
                      addressVerified = value! ;
                    }),
                  ),
                ],
              ),
              10.h,
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
          text: "Search",
          buttonHeight: AppDimens.buttonHeight45,
          buttonWidth: AppDimens.spacing90,
          fontSize: AppDimens.textSize14,
          borderRadius: AppDimens.buttonRadius16,
          onPressed: () {
            
            FocusScope.of(context).unfocus();

            // final reportsCubit = context.read<ReportsCubit>() ;

            // reportsCubit.dateFrom = dateFromController.text;
            // reportsCubit.dateTo = dateToController.text;
            // reportsCubit.expiryFrom = dateExpiryFromController.text;
            // reportsCubit.expiryTo = dateExpiryToController.text;
            // reportsCubit.filterStore = storeSelected;
            // reportsCubit.filterUser = salesPersonSelected;

            final formdata = {
              'store_id' : storeSelected?.id ?? '',
              'vip'  : vip == 'Yes' ? '1' : '0',
              'user_id' : '',
              'state' : '',
              'country' : '',
              'address_verified' : addressVerified == 'Yes' ? '1' : '0',
              'ship' : origination.value,
              'unsubscribed' : unsubscribed == 'Yes' ? '1' : '0',
              'sales_from' : salesFromCont.text,
              'sales_to' : salesToCont.text,
              'sales_date_from' : salesFromDateCont.text,
              'sales_date_to' : salesToDateCont.text,
              'birthday_from' : birthFromDateCont.text,
              'birthday_to' : birthToDateCont.text,
              'has_birthday' : hasBirthday == 'Yes' ? '1' : '0',
              'has_anniversary' : hasAniversary == 'Yes' ? '1' : '0',
              'anniversary_from' : anniversaryFromDateCont.text,
              'anniversary_to' : anniversaryToDateCont.text,
            } ;

            context.pop();

            widget.onSearch(formdata);
          },
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode? focusNode, {
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
}