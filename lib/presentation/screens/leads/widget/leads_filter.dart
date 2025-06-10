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
import 'package:joes_jwellery_crm/presentation/screens/leads/widget/leads_status_dropdown.dart';
import 'package:joes_jwellery_crm/presentation/widgets/assoc_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class LeadsFilter extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearch;
  const LeadsFilter({super.key, required this.onSearch});

  @override
  State<LeadsFilter> createState() => _LeadsFilterState();
}

class _LeadsFilterState extends State<LeadsFilter> {

  Stores? storeSelected ;
  Users? assocSelected ;
  String status = '';

  TextEditingController priceFromCont = TextEditingController(); 
  TextEditingController priceToCont = TextEditingController(); 
  TextEditingController createdFromCont = TextEditingController(); 
  TextEditingController createdToCont = TextEditingController(); 
  TextEditingController followupFromDateCont = TextEditingController(); 
  TextEditingController followupToDateCont = TextEditingController(); 
  
  FocusNode priceFromFocus = FocusNode();
  FocusNode priceToFocus = FocusNode();

  
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

              TextfieldTitleTextWidget(title: "Status"),
              5.h,
              LeadsStatusDropdown(
                onSelected:(selected) {
                  status = selected.value ;
                },
                initialSelected: LeadsStatusOption(value: '', display: ''), 
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

              TextfieldTitleTextWidget(title: "Follo-up from"),
              GestureDetector(
                onTap: () async{
                  followupFromDateCont.text = await getDateFromUser(context);
                },
                child: _buildField("Follo-up from",followupFromDateCont, null, isEnable: false),
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Follo-up to"),
              GestureDetector(
                onTap: () async{
                  followupToDateCont.text = await getDateFromUser(context);
                },
                child: _buildField("Follo-up to",followupToDateCont, null, isEnable: false),
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Price from"),
              _buildField("Price from",priceFromCont, priceFromFocus, inputType: TextInputType.number), 
              7.h,

              TextfieldTitleTextWidget(title: "Price to"),
              _buildField("Price to",priceToCont, priceToFocus, inputType: TextInputType.number), 
              7.h,

              TextfieldTitleTextWidget(title: "Created from"),
              GestureDetector(
                onTap: () async{
                  createdFromCont.text = await getDateFromUser(context);
                },
                child: _buildField("created from",createdFromCont, null, isEnable: false),
              ),
              7.h,

              TextfieldTitleTextWidget(title: "Created to"),
              GestureDetector(
                onTap: () async{
                  createdToCont.text = await getDateFromUser(context);
                },
                child: _buildField("Created to", createdToCont, null, isEnable: false),
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

            final formdata = {
              'store_id' : storeSelected?.id ?? '',
              'status' : status,
              'user_id' : assocSelected?.id ?? '',
              'follow_date_from' : followupFromDateCont.text,
              'follow_date_to' : followupToDateCont.text,
              'amount_from' : priceFromCont.text,
              'amount_to' : priceToCont.text,
              'creation_date_from' : createdFromCont.text,
              'creation_date_to' : createdToCont.text,
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