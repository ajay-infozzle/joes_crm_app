import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_header.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/edit_customer_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/expandable_section.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/send_email_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/take_customer_photo_dialog.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String name;
  final String id;
  const CustomerDetailScreen({super.key, required this.name, required this.id});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerCubit>().fetchSingleCustomer(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.primary,
            size: AppDimens.spacing20,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.more_vert,
          //     color: AppColor.primary,
          //     size: AppDimens.spacing20,
          //   ),
          // ),
          PopupMenuButton<String>(
            color: AppColor.white,
            icon: const Icon(
              Icons.more_vert,
              color: AppColor.primary,
              size: AppDimens.spacing20,
            ),
            onSelected: (value) {
              if (value == 'edit') {
                onEditSelected(context : context);
              } else if (value == 'delete') {
                showAppSnackBar(context, message: "Not available !");
              } else if (value == 'take_photo') {
                onTakePhotoSelected(context : context);
              } else if (value == 'send_him_email') {
                onSendHimEmailSelected(context : context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.editIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Edit')
                  ],
                ),
              ),

              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.deleteIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Delete')
                  ],
                ),
              ),

              PopupMenuItem<String>(
                value: 'take_photo',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.cameraIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Take Photo')
                  ],
                ),
              ),

              PopupMenuItem<String>(
                value: 'send_him_email',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.emailIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Send Him Email')
                  ],
                ),
              ),

              PopupMenuItem<String>(
                value: 'send_her_email',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.emailIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Send Her Email')
                  ],
                ),
              ),

              PopupMenuItem<String>(
                value: 'send_water_taxi_email',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.emailIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Send Water Taxi Email')
                  ],
                ),
              ),
              
              PopupMenuItem<String>(
                value: 'send_appr_cert_email',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.emailIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Send Appraisal Certificate Email')
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<CustomerCubit, CustomerState>(
            listener: (context, state) {
              if(state is CustomerEmailSentError){
                showAppSnackBar(context, message: state.message);
              }
            },
            buildWhen: (previous, current) => !(current is CustomerEmailSent || current is CustomerSendingEmail || current is CustomerEmailSentError ),
            builder: (context, state) {
              if (state is CustomerLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColor.primary,));
              } 
              else if (state is CustomerError) {
                return RetryWidget(
                  onTap: () async{
                    context.read<CustomerCubit>().fetchSingleCustomer(id: widget.id);
                  },
                );
              } 
              else if (state is CustomerLoaded) {
                final customer = state.customer;

                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: width * 0.05,
                      ),
                      child: CustomerHeader(customer: customer),
                    ),

                    15.h,

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "Basic Details",
                        content: {
                          "ID": customer.id ?? '-',
                          "Store": customer.store ?? '-',
                          "Title": '-',
                          "Name": customer.name ?? '-',
                          "Surname": customer.surname ?? '-',
                          "Email": customer.email ?? '-',
                          "Country": customer.country ?? '-',
                          "Contact Number": customer.phone ?? '-',
                          "Birthday": customer.birthday ?? '-',
                          "Anniversary": customer.anniversary ?? '-',
                          "Spouse Name": customer.spouseName ?? '-',
                          "Wife Email": customer.wifeEmail ?? '-',
                          "Wife Phone": customer.wifePhone ?? '-',
                          "Wife Birthday": customer.wifeBirthday ?? '-',
                          "Total Sales": customer.totalSales ?? '-',
                          "Last Sale Date": customer.lastSaleDate ?? '-',
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "Sales",
                        isSales: true,
                        salesList: customer.sales,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "SMS Log",
                        isSmsLogs: true,
                        smsLogList: customer.smsLog,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "Activity Stream",
                        isActivityStream: true,
                        activityList: customer.activityStream,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "Communication Log",
                        isCommLog: true,
                        commList: customer.communicationLog,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: ExpandableSection(
                        title: "Wish List",
                        isWishList: true,
                        wishList: customer.wishList,
                      ),
                    ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator(color: AppColor.primary,));
            },
          ),
        ),
      ),
    );
  }
  
  void onEditSelected({required BuildContext context}) {
    final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;

    final nameFocus = FocusNode();
    final spouseNameFocus = FocusNode();
    final surnameFocus = FocusNode();
    final emailFocus = FocusNode();
    final wifeEmailFocus = FocusNode();
    final countryFocus = FocusNode();
    final phoneFocus = FocusNode();
    final wifePhoneFocus = FocusNode();

    final nameController = TextEditingController(text: customer.name ?? '');
    final spouseNameController = TextEditingController(text: customer.spouseName ?? '');
    final surnameController = TextEditingController(text: customer.surname ?? '');
    final emailController = TextEditingController(text: customer.email ?? '');
    final wifeEmailController = TextEditingController(text: customer.wifeEmail ?? '');
    final countryController = TextEditingController(text: customer.country ?? '');
    final phoneController = TextEditingController(text: customer.phone ?? '');
    final wifePhoneController = TextEditingController(text: customer.wifePhone ?? '');

    showDialog(
      context: context,
      builder: (_) => EditCustomerDialog(
        nameController: nameController,
        spouseNameController: spouseNameController,
        surnameController: surnameController,
        emailController: emailController,
        wifeEmailController: wifeEmailController,
        countryController: countryController,
        phoneController: phoneController,
        wifePhoneController: wifePhoneController,
        nameFocus: nameFocus,
        spouseNameFocus: spouseNameFocus,
        surnameFocus: surnameFocus,
        emailFocus: emailFocus,
        wifeEmailFocus: wifeEmailFocus,
        countryFocus: countryFocus,
        phoneFocus: phoneFocus,
        wifePhoneFocus: wifePhoneFocus,
        onSave: () {
          context.read<CustomerCubit>().updateCustomer(
            id: widget.id,
            name: nameController.text,
            surname: surnameController.text,
            email: emailController.text,
            phone: phoneController.text,
            country: countryController.text,
            spouseName: spouseNameController.text,
            wifeEmail: wifeEmailController.text,
            wifePhone: wifePhoneController.text,
          );
        },
      ),
    ).then((_) {
      // nameFocus.dispose();
      // spouseNameFocus.dispose();
      // surnameFocus.dispose();
      // emailFocus.dispose();
      // wifeEmailFocus.dispose();
      // countryFocus.dispose();
      // phoneFocus.dispose();
      // wifePhoneFocus.dispose();

      // nameController.dispose();
      // spouseNameController.dispose();
      // surnameController.dispose();
      // emailController.dispose();
      // wifeEmailController.dispose();
      // countryController.dispose();
      // phoneController.dispose();
      // wifePhoneController.dispose();
    });
  }

  void onTakePhotoSelected({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => TakeCustomerPhotoDialog(
        onSave: (file) {
          context.read<CustomerCubit>().updateCustomerPhoto(
            file: file,
            id: widget.id 
          );
        },
      ),
    );
  }
  
  void onSendHimEmailSelected({required BuildContext context}) {
    final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;

    final subjectFocus = FocusNode();
    final messageFocus = FocusNode();
    
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => SendEmailDialog(
        subjectController: subjectController, 
        messageController: messageController, 
        subjectFocus: subjectFocus, 
        messageFocus: messageFocus, 
        title: 'Send Him Email',
        onSend: () async{
          await context.read<CustomerCubit>().sendHimEmail(
            custId: customer.id!,
            subject: subjectController.text,
            message: messageController.text 
          );
        },
      ),
    );
  }

}
