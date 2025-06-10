import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/customer/customer_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/customer_header.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/edit_customer_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/expandable_section.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/send_appr_cirt_email.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/send_email_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/send_water_taxi_email.dart';
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
    context.read<CustomerCubit>().currentCustomer = null;
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
                context.read<CustomerCubit>().currentCustomer != null ? onEditSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'delete') {
                showAppSnackBar(context, message: "Not available !");
              } else if (value == 'take_photo') {
                context.read<CustomerCubit>().currentCustomer != null ? onTakePhotoSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'send_him_email') {
                context.read<CustomerCubit>().currentCustomer != null ? onSendHimEmailSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'send_her_email') {
                context.read<CustomerCubit>().currentCustomer != null ? onSendHerEmailSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'send_water_taxi_email') {
                context.read<CustomerCubit>().currentCustomer != null ? onSendWaterTaxiEmailSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'send_appr_cert_email') {
                context.read<CustomerCubit>().currentCustomer != null ? onSendApprCertEmailSelected(context : context) : showAppSnackBar(context, message: "Not available !");
              } else if (value == 'add_sale') {
                context.pushNamed(
                  RoutesName.addSaleScreen,
                  extra: context.read<CustomerCubit>().currentCustomer!.id ?? ""
                );
              } else if (value == 'add_wish') {
                context.pushNamed(
                  RoutesName.addWishScreen,
                  extra: context.read<CustomerCubit>().currentCustomer!.id ?? ""
                );
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

              PopupMenuItem<String>(
                value: 'add_sale',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.addSaleIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Add Sale')
                  ],
                ),
              ),
              
              PopupMenuItem<String>(
                value: 'add_wish',
                child: Row(
                  children: [
                    Image.asset(AssetsConstant.addSaleIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                    5.w,
                    Text('Add Wish')
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
                          "Title": customer.title?.toLowerCase().capitalizeFirst() ?? '-',
                          "His name": customer.name ?? '-',
                          "Her name": customer.spouseName ?? '-',
                          "Surname": customer.surname ?? '-',
                          "His email": customer.email ?? '-',
                          "Her email": customer.wifeEmail ?? '-',
                          "Country": customer.country ?? '-',
                          "His cell number": customer.phone ?? '-',
                          "Her cell number": customer.wifePhone ?? '-',
                          "His birthday": customer.birthday ?? '-',
                          "Her birthday": customer.wifeBirthday ?? '-',
                          "Anniversary": customer.anniversary ?? '-',
                          "Total sales": customer.totalSales ?? '-',
                          "Last sale date": customer.lastSaleDate ?? '-',
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
    // final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;
    final customer = context.read<CustomerCubit>().currentCustomer!;

    final nameFocus = FocusNode();
    final spouseNameFocus = FocusNode();
    final surnameFocus = FocusNode();
    final emailFocus = FocusNode();
    final wifeEmailFocus = FocusNode();
    final countryFocus = FocusNode();
    final phoneFocus = FocusNode();
    final wifePhoneFocus = FocusNode();
    final notesFocus = FocusNode();

    final nameController = TextEditingController(text: customer.name ?? '');
    final spouseNameController = TextEditingController(text: customer.spouseName ?? '');
    final surnameController = TextEditingController(text: customer.surname ?? '');
    final emailController = TextEditingController(text: customer.email ?? '');
    final wifeEmailController = TextEditingController(text: customer.wifeEmail ?? '');
    final notesController = TextEditingController(text: customer.notes ?? '');
    // final countryController = TextEditingController(text: customer.country ?? '');
    final phoneController = TextEditingController(text: customer.phone ?? '');
    final wifePhoneController = TextEditingController(text: customer.wifePhone ?? '');

    context.read<CustomerCubit>().country = context.read<CustomerCubit>().getCountry(customer.country ?? "") ;

    showDialog(
      context: context,
      builder: (_) => EditCustomerDialog(
        nameController: nameController,
        spouseNameController: spouseNameController,
        surnameController: surnameController,
        emailController: emailController,
        wifeEmailController: wifeEmailController,
        // countryController: countryController,
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
        notesController: notesController,
        notesFocus: notesFocus,
        onSave: () {
          context.read<CustomerCubit>().updateCustomer(
            id: widget.id,
            name: nameController.text,
            surname: surnameController.text,
            email: emailController.text,
            phone: phoneController.text,
            country: context.read<CustomerCubit>().checkCountry(),
            spouseName: spouseNameController.text,
            wifeEmail: wifeEmailController.text,
            wifePhone: wifePhoneController.text,
            notes: notesController.text,
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
    // final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;
    final customer = context.read<CustomerCubit>().currentCustomer!;

    final subjectFocus = FocusNode();
    final messageFocus = FocusNode();
    final toFocus = FocusNode();
    
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    final toController = TextEditingController(text: customer.email);

    showDialog(
      context: context,
      builder: (_) => SendEmailDialog(
        subjectController: subjectController, 
        messageController: messageController, 
        toController: toController,
        toFocus: toFocus,
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

  void onSendHerEmailSelected({required BuildContext context}) {
    // final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;
    final customer = context.read<CustomerCubit>().currentCustomer!;

    final subjectFocus = FocusNode();
    final messageFocus = FocusNode();
    final toFocus = FocusNode();
    
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    final toController = TextEditingController(text: customer.wifeEmail?? "");

    showDialog(
      context: context,
      builder: (_) => SendEmailDialog(
        subjectController: subjectController, 
        messageController: messageController, 
        toController: toController,
        toFocus: toFocus,
        subjectFocus: subjectFocus, 
        messageFocus: messageFocus, 
        title: 'Send Her Email',
        onSend: () async{
          await context.read<CustomerCubit>().sendHerEmail(
            custId: customer.id!,
            subject: subjectController.text,
            message: messageController.text,
            herEmail: customer.wifeEmail?? "" 
          );
        },
      ),
    );
  }

  void onSendWaterTaxiEmailSelected({required BuildContext context}) {
    // final customer = (context.read<CustomerCubit>().state as CustomerLoaded).customer;
    final customer = context.read<CustomerCubit>().currentCustomer!;
    final email = customer.email!.isNotEmpty ? customer.email : customer.wifeEmail! ;
    showDialog(
      context: context,
      builder: (_) => SendWaterTaxiEmailDialog(
        toEmail: email!, 
        onSend: (formdata) async{
          formdata["customer_id"] = customer.id;
          await context.read<CustomerCubit>().sendWaterTaxiEmail(
            formdata: formdata
          );
        },
      ),
    );
  }

  void onSendApprCertEmailSelected({required BuildContext context}) {
    final customer = context.read<CustomerCubit>().currentCustomer!;
    showDialog(
      context: context,
      builder: (_) => SendApprCirtEmail(
        customer: customer, 
        onSend: (formdata) async{
          await context.read<CustomerCubit>().sendApprCertEmail(
            formdata: formdata
          );
        },
      ),
    );
  }

}
