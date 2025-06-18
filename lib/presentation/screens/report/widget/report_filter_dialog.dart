import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/reports/reports_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/assoc_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class ReportFilterDialog extends StatefulWidget {
  final int index ;
  final VoidCallback onSearch;
  const ReportFilterDialog({super.key, required this.index, required this.onSearch});

  @override
  State<ReportFilterDialog> createState() => _ReportFilterDialogState();
}

class _ReportFilterDialogState extends State<ReportFilterDialog> {

  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController dateExpiryFromController = TextEditingController();
  TextEditingController dateExpiryToController = TextEditingController();

  Stores? storeSelected ;
  Users? salesPersonSelected ;


  @override
  void initState() {
    super.initState();

    updateDateFromAndTo();
  }

  void updateDateFromAndTo(){
    final now = DateTime.now();
    final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    dateFromController.text = DateFormat('yyyy-MM-dd').format(oneMonthAgo);
    dateToController.text = DateFormat('yyyy-MM-dd').format(now);
  }

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
              TextfieldTitleTextWidget(title: "Date from"),
              GestureDetector(
                onTap: () async{
                  final date = await getDateFromUser(context) ;
                  if(date.isNotEmpty){
                    dateFromController.text = date ;
                  }
                },
                child: _buildField("Date from", dateFromController, null, enable:  false),
              ),
              7.h,

              TextfieldTitleTextWidget(title: "To"),
              GestureDetector(
                onTap: () async{
                  final date = await getDateFromUser(context) ;
                  if(date.isNotEmpty){
                    dateToController.text = date ;
                  }
                },
                child: _buildField("To", dateToController, null, enable:  false),
              ),
              7.h,

              if(widget.index == 0)
              Column(
                children: [
                  TextfieldTitleTextWidget(title: "Expiry from"),
                  GestureDetector(
                    onTap: () async{
                      dateExpiryFromController.text = await getDateFromUser(context) ;
                    },
                    child: _buildField("Expiry from", dateExpiryFromController, null, enable:  false),
                  ),
                  7.h,
                ],
              ),

              if(widget.index == 0)
              Column(
                children: [
                  TextfieldTitleTextWidget(title: "Expiry to"),
                  GestureDetector(
                    onTap: () async{
                      dateExpiryToController.text = await getDateFromUser(context) ;
                    },
                    child: _buildField("Expiry to", dateExpiryToController, null, enable:  false),
                  ),
                  7.h,
                ],
              ),

              TextfieldTitleTextWidget(title: "Store"),
              5.h,
              StoreDropdown(
                storeList: context.read<HomeCubit>().storeList, 
                onSelected: (selectedStore) => setState(() {
                  storeSelected = selectedStore ;
                }),
                initialSelected: storeSelected,
              ),
              10.h,

              TextfieldTitleTextWidget(title: "Sales Person"),
              5.h,
              AssocDropdown(
                usersList: context.read<HomeCubit>().salesAssocList, 
                onSelected: (selectedUser) => setState(() {
                  salesPersonSelected = selectedUser ;
                }),
                initialSelected: salesPersonSelected,
                title: "Sales Person",
              ),
              30.h,
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

            final reportsCubit = context.read<ReportsCubit>() ;

            reportsCubit.dateFrom = dateFromController.text;
            reportsCubit.dateTo = dateToController.text;
            reportsCubit.expiryFrom = dateExpiryFromController.text;
            reportsCubit.expiryTo = dateExpiryToController.text;
            reportsCubit.filterStore = storeSelected;
            reportsCubit.filterUser = salesPersonSelected;

            context.pop();

            widget.onSearch();
          },
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    FocusNode? focusNode, {
    bool enable = true,
    int maxline = 1
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
        textInputAction: TextInputAction.next,
        maxline: maxline,
      ),
    );
  }
}