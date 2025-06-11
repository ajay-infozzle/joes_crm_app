import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/api_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/data/model/all_wishlist_model.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/wishlist/wishlist_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/auth/widget/textfield_title_text_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/assoc_dropdown_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_button.dart';
import 'package:joes_jwellery_crm/presentation/widgets/custom_text_field.dart';

class EditWishScreen extends StatefulWidget {
  final Wish wishData ;
  const EditWishScreen({super.key, required this.wishData});

  @override
  State<EditWishScreen> createState() => _EditWishScreenState();
}

class _EditWishScreenState extends State<EditWishScreen> {

  // final TextEditingController photoController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController followDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  // final TextEditingController assocController = TextEditingController();
  // final TextEditingController assoc2Controller = TextEditingController();

  final FocusNode productFocus = FocusNode();
  final FocusNode referenceFocus = FocusNode();
  final FocusNode amountFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();

  Users? assoc ;
  Users? assoc2 ;

  @override
  void initState() {
    super.initState();

    productController.text = widget.wishData.product ?? '' ;
    referenceController.text = widget.wishData.referenceNo ?? '' ;
    amountController.text = widget.wishData.price ?? '' ;
    followDateController.text = widget.wishData.followDate ?? '' ;

    assoc = getUserObj(
      context,
      (widget.wishData.salesAssociates?.isNotEmpty ?? false)
          ? widget.wishData.salesAssociates!.first.id ?? ''
          : '',
    );

    
    assoc2 = getUserObj(context, widget.wishData.salesAssoc2 ?? '');

    context.read<WishlistCubit>().currentPickedImg = null ;
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
          "Edit Wish",
          style: TextStyle(
            fontSize: AppDimens.textSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child:  BlocConsumer<WishlistCubit, WishlistState>( 
          listener: (context, state) {
            if(state is WishFormSaved){
              context.pop();
            }
            if(state is WishFormError){
              showToast(msg: state.message, backColor: AppColor.red);
            }
          },
          builder: (context, state) {
            WishlistCubit wishlistCubit = context.read<WishlistCubit>();

            if(state is WishFormLoading){
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
                  TextfieldTitleTextWidget(title: "Photo"),
                  GestureDetector(
                    onTap: () => context.read<WishlistCubit>().pickImage(),
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
                      child: context.read<WishlistCubit>().currentPickedImg != null
                          ? Image.file(context.read<WishlistCubit>().currentPickedImg!, fit: BoxFit.cover)
                          : ( widget.wishData.photo == null || widget.wishData.photo == ''
                            ? const Text("Choose Image", style: TextStyle(color: Colors.black54))
                            : Image.network(
                              "${ApiConstant.demoBaseUrl}${widget.wishData.photo}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(color: AppColor.primary.withValues(alpha: .04),),
                              )
                            ),
                    ),
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Product"),
                  _buildField("Product", productController, productFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Reference no."),
                  _buildField("Reference no.", referenceController, referenceFocus),
                  7.h,

                  TextfieldTitleTextWidget(title: "Price"),
                  _buildField("Price", amountController, amountFocus, inputType: TextInputType.number),
                  7.h,

                  TextfieldTitleTextWidget(title: "Follow-up Date"),
                  GestureDetector(
                    child: _buildField(
                      "Follow-up Date",
                      followDateController,
                      null,
                      isEnable: false,
                    ),
                    onTap: () async {
                      followDateController.text = await getDateFromUser(context);
                    },
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Sale Associate(s)"),
                  AssocDropdown(
                    usersList: context.read<HomeCubit>().usersList, 
                    onSelected: (selectedUser) {
                      assoc = selectedUser ;
                      wishlistCubit.updateForm();
                    },
                    initialSelected: assoc,
                  ),
                  7.h,

                  TextfieldTitleTextWidget(title: "Sale Associate 2"),
                  AssocDropdown(
                    usersList: context.read<HomeCubit>().usersList, 
                    onSelected: (selectedUser) {
                      assoc2 = selectedUser ;
                      wishlistCubit.updateForm();
                    },
                    initialSelected: assoc2,
                  ),
                  30.h,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        text: "Edit",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          wishlistCubit.editWish(formdata: {
                            'id' : widget.wishData.id,
                            'product' : productController.text,
                            'reference_no' : referenceController.text,
                            'price' : amountController.text,
                            'follow_date' : followDateController.text,
                            // 'user_id' : assoc?.id ?? '',
                            'sales_assoc_2' : assoc2?.id ?? '',
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