import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/assoc_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/radio_box_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class SalesFilter extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearch;
  const SalesFilter({super.key, required this.onSearch});

  @override
  State<SalesFilter> createState() => _SalesFilterState();
}

class _SalesFilterState extends State<SalesFilter> {

  Stores? storeSelected ;
  Users? assocSelected ;

  String hasAniversary = 'No';
  String hasBirthday = 'No';


  TextEditingController salesFromDateCont = TextEditingController(); 
  TextEditingController salesToDateCont = TextEditingController(); 
  TextEditingController birthFromDateCont = TextEditingController(); 
  TextEditingController birthToDateCont = TextEditingController(); 
  TextEditingController anniversaryFromDateCont = TextEditingController(); 
  TextEditingController anniversaryToDateCont = TextEditingController(); 

  TextEditingController amountFromCont = TextEditingController(); 
  TextEditingController amountToCont = TextEditingController(); 

  FocusNode salesFromFocus = FocusNode();
  FocusNode salesToFocus = FocusNode();
  FocusNode amountFromFocus = FocusNode();
  FocusNode amountToFocus = FocusNode();

  
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

              TextfieldTitleTextWidget(title: "Sales Associate"),
              5.h,
              AssocDropdown(
                usersList: context.read<HomeCubit>().usersList, 
                onSelected: (selectedUser) {
                  setState(() {
                    assocSelected = selectedUser ;
                  });
                },
                initialSelected: assocSelected,
              ),
              12.h,
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Date from"),
                        GestureDetector(
                          child: _buildField(
                            "Date from",
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
                        TextfieldTitleTextWidget(title: "Date to"),
                        GestureDetector(
                          child: _buildField(
                            "Date to",
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
                        TextfieldTitleTextWidget(title: "Amount from"),
                        _buildField("Amount from", amountFromCont, amountFromFocus, inputType: TextInputType.number),
                      ],
                    )  
                  ),
                  10.w,
                  Expanded(
                    child: Column(
                      children: [
                        TextfieldTitleTextWidget(title: "Amount to"),
                        _buildField("Amount to", amountToCont, amountToFocus, inputType: TextInputType.number),
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
                            birthFromDateCont.text = getDMY(await getDateFromUser(context));
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
                            birthToDateCont.text = getDMY(await getDateFromUser(context));
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
                            anniversaryFromDateCont.text = getDMY(await getDateFromUser(context));
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
                            anniversaryToDateCont.text = getDMY(await getDateFromUser(context));
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


            final formdata = {
              'store_id' : storeSelected?.id ?? '',
              'user_id' : assocSelected?.id ?? '',
              'state' : '',
              'country' : '',
              'date_from' : salesFromDateCont.text,
              'date_to' : salesToDateCont.text,
              'year_from' : '',
              'year_to' : '',
              'month' : '',
              'amount_from' : amountFromCont.text,
              'amount_to' : amountToCont.text,
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