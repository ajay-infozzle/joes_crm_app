import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/sale/sale_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';
import 'package:joes_jwellery_crm/presentation/widgets/store_drop_down_widget.dart';

class AddSaleScreen extends StatefulWidget {
  final String custId ;
  const AddSaleScreen({super.key, required this.custId});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {

  final TextEditingController saleDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController assocController = TextEditingController();
  final TextEditingController pdfController = TextEditingController();

  final FocusNode saleDateFocus = FocusNode();
  final FocusNode amountFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();

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
          "Add New Sale",
          style: TextStyle(
            fontSize: AppDimens.textSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child:  BlocConsumer<SaleCubit, SaleState>( 
          listener: (context, state) {
            if(state is SaleFormError){
              showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
            }
            
            if(state is SaleFormSaved){
              saleDateController.clear();
              amountController.clear();
              notesController.clear();
              assocController.clear();
              pdfController.clear();
              context.read<SaleCubit>().currentPickedPdf = null ;
              context.read<SaleCubit>().selectedAssociates = [] ;
              context.read<SaleCubit>().store = null ;

              context.pop();
              context.read<CustomerCubit>().fetchSingleCustomer(id: context.read<CustomerCubit>().currentCustomer!.id ?? '');
            }
          },
          builder: (context, state) {
            SaleCubit saleCubit = context.read<SaleCubit>();

            if(state is SaleFormLoading){
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
                  TextfieldTitleTextWidget(title: "Store",),
                  5.h,
                  StoreDropdown(
                    storeList: context.read<HomeCubit>().storeList, 
                    onSelected: (selectedStore) => saleCubit.changeStore(selectedStore),
                    initialSelected: saleCubit.store,
                  ),
                  10.h,

                  TextfieldTitleTextWidget(title: "Sale Associate(s)"),
                  GestureDetector(
                    onTap: () {
                      showSaleAssociatesDialog(
                        context: context, 
                        associates: context.read<HomeCubit>().salesAssocList, 
                        initiallySelectedIds: saleCubit.selectedAssociates.map((e) => e.id ?? '').toList(), 
                        onDone: (assocs) {
                          saleCubit.selectedAssociates = assocs ;
                          assocController.text = assocs.map((e) => e.name ?? '').join(',');
                        },
                      );
                    },
                    child: _buildField("Select Sale Associates", assocController, null, isEnable: false),
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Sale Date"),
                  GestureDetector(
                    child: _buildField(
                      "Sale Date",
                      saleDateController,
                      null,
                      isEnable: false,
                    ),
                    onTap: () async {
                      saleDateController.text = await getDateFromUserTillToday(context);
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Amount"),
                  _buildField("Amount", amountController, amountFocus, inputType: TextInputType.number),
                  7.h,

                  TextfieldTitleTextWidget(title: "Notes"),
                  _buildField(
                    "Notes",
                    notesController,
                    notesFocus,
                    maxline: 4,
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Receipt Pdf"),
                  GestureDetector(
                    onTap: () async{
                      await saleCubit.pickPdf();
                      pdfController.text = saleCubit.currentPickedPdf?.files.single.name ?? "";
                    },
                    child: _buildField("Upload Pdf", pdfController, null, isEnable: false),
                  ),
                  30.h,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Add",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          saleCubit.addSale(formdata: {
                            'customer_id' : widget.custId,
                            'store_id' : saleCubit.store?.id,
                            'sale_date' : saleDateController.text,
                            'amount' : amountController.text,
                            'notes' : notesController.text,
                            // 'user_id' : assocController.text,
                          });
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
        )
      ),
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

  Future<void> showSaleAssociatesDialog({
    required BuildContext context,
    required List<Users> associates,
    required List<String> initiallySelectedIds,
    required Function(List<Users>) onDone,
  }) async {
    final Set<String> selectedIds = Set<String>.from(initiallySelectedIds);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Sale Associates", textAlign: TextAlign.center,),
          contentPadding: EdgeInsets.all(AppDimens.spacing15),
          insetPadding: EdgeInsets.all(AppDimens.spacing15),
          surfaceTintColor: AppColor.white,
          titlePadding: EdgeInsets.all(AppDimens.spacing10),
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: associates.length,
              itemBuilder: (context, index) {
                final user = associates[index];
                return CheckboxListTile(
                  title: Text(user.name ?? '', style: TextStyle(color: AppColor.primary),),
                  value: selectedIds.contains(user.id),
                  activeColor: AppColor.primary,
                  onChanged: (bool? value) {
                    if (value == true) {
                      selectedIds.add(user.id!);
                    } else {
                      selectedIds.remove(user.id);
                    }
                    (context as Element).markNeedsBuild(); 
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           
            CustomButton(
              text: "Done",
              buttonHeight: AppDimens.buttonHeight45,
              buttonWidth: AppDimens.spacing90,
              fontSize: AppDimens.textSize14,
              borderRadius: AppDimens.buttonRadius16,
              onPressed: () {
                final selectedUsers = associates
                    .where((user) => selectedIds.contains(user.id))
                    .toList();

                Navigator.pop(context);
                onDone(selectedUsers);
              },
            ),
          ],
        );
      },
    );
  }

}