import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/send_email_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/customer/widget/take_customer_photo_dialog.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class LeadScreen extends StatefulWidget {
  final String id;
  const LeadScreen({super.key, required this.id});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  void initState() {
    super.initState();

    context.read<LeadsCubit>().getLeadDetail(widget.id);
  }

  String getUserName(String userId) {
    String name = "_";
    context.read<HomeCubit>().usersList.forEach((e) {
      if (userId == e.id) {
        name = e.name ?? "_";
      }
    });
    return name.toLowerCase().capitalizeFirst();
  }

  String isCompleted(String value) {
    if (value == "0") {
      return "No";
    } else {
      return "Yes";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.greenishGrey,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Lead",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.spacing18,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.primary,
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
                context.pushNamed(
                  RoutesName.editLeadScreen,
                  extra: context.read<LeadsCubit>().currentLeadDetail,
                );
              } else if (value == 'take_photo') {
                onTakePhotoSelected(context: context);
              } else if (value == 'send_email') {
                onSendEmailSelected(context : context);
              } else if (value == 'follow_up') {
                // onFollowUpSelected(context : context);
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Image.asset(
                          AssetsConstant.editIcon,
                          width: AppDimens.spacing15,
                          height: AppDimens.spacing15,
                          color: AppColor.primary,
                        ),
                        5.w,
                        Text('Edit'),
                      ],
                    ),
                  ),

                  // PopupMenuItem<String>(
                  //   value: 'delete',
                  //   child: Row(
                  //     children: [
                  //       Image.asset(AssetsConstant.deleteIcon, width: AppDimens.spacing15, height: AppDimens.spacing15, color: AppColor.primary),
                  //       5.w,
                  //       Text('Delete')
                  //     ],
                  //   ),
                  // ),
                  PopupMenuItem<String>(
                    value: 'take_photo',
                    child: Row(
                      children: [
                        Image.asset(
                          AssetsConstant.cameraIcon,
                          width: AppDimens.spacing15,
                          height: AppDimens.spacing15,
                          color: AppColor.primary,
                        ),
                        5.w,
                        Text('Take Photo'),
                      ],
                    ),
                  ),

                  PopupMenuItem<String>(
                    value: 'send_email',
                    child: Row(
                      children: [
                        Image.asset(
                          AssetsConstant.emailIcon,
                          width: AppDimens.spacing15,
                          height: AppDimens.spacing15,
                          color: AppColor.primary,
                        ),
                        5.w,
                        Text('Send Email'),
                      ],
                    ),
                  ),

                  PopupMenuItem<String>(
                    value: 'follow_up',
                    child: Row(
                      children: [
                        Image.asset(
                          AssetsConstant.replyIcon,
                          width: AppDimens.spacing15,
                          height: AppDimens.spacing15,
                          color: AppColor.primary,
                        ),
                        5.w,
                        Text('Follow-up'),
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
          child: BlocConsumer<LeadsCubit, LeadsState>(
            listener: (context, state) {
              if(state is LeadsPhotoError ){
                showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              }
              if(state is LeadsEmailSentError){
                showAppSnackBar(context, message: state.message, backgroundColor: AppColor.red);
              }
            },
            builder: (context, state) {
              LeadsCubit leadCubit = context.read<LeadsCubit>();

              if (state is LeadsDetailLoading || state is LeadsPhotoUpdating || state is LeadsSendingEmail) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                );
              } else if (state is LeadsDetailError) {
                return Expanded(
                  child: RetryWidget(
                    onTap: () async {
                      context.read<LeadsCubit>().getLeadDetail(widget.id);
                    },
                  ),
                );
              } else if (leadCubit.currentLeadDetail != null) {
                return Container(
                  margin: const EdgeInsets.all(AppDimens.spacing10),
                  padding: const EdgeInsets.all(AppDimens.spacing10),
                  decoration: BoxDecoration(
                    color: AppColor.greenishGrey.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(AppDimens.radius12),
                  ),
                  child: RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async {
                      context.read<LeadsCubit>().getLeadDetail(widget.id);
                    },
                    child: ListView(
                      children: [
                        contentRow(
                          title: "Id",
                          data: leadCubit.currentLeadDetail?.id ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Store",
                          data: leadCubit.currentLeadDetail?.store ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Sales associate",
                          data: getUserName(
                            leadCubit.currentLeadDetail?.salesAssoc2 ?? "_",
                          ),
                        ),
                        10.h,

                        contentRow(
                          title: "Title",
                          data:
                              leadCubit.currentLeadDetail?.title
                                  ?.toLowerCase()
                                  .capitalizeFirst() ??
                              "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Name",
                          data: leadCubit.currentLeadDetail?.name ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Surname",
                          data: leadCubit.currentLeadDetail?.surname ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Follow-up Date",
                          data:
                              formatDateTime(
                                leadCubit.currentLeadDetail?.followDate ?? "",
                              )["date"] ??
                              "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Amount Quoted",
                          data:
                              "\$ ${leadCubit.currentLeadDetail?.amount ?? "_"}",
                        ),
                        10.h,

                        contentRow(
                          title: "Email",
                          data: leadCubit.currentLeadDetail?.email ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Phone",
                          data: leadCubit.currentLeadDetail?.phone ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Address",
                          data: leadCubit.currentLeadDetail?.address ?? "_",
                        ),
                        10.h,

                        contentRow(
                          title: "Created By",
                          data: getUserName(
                            leadCubit.currentLeadDetail?.createdBy ?? "_",
                          ),
                        ),
                        10.h,

                        if(leadCubit.currentLeadDetail?.customerId != "0") //i.e for existing customer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.pushNamed(
                                  RoutesName.customerDetailScreen,
                                  extra: {
                                    'name':
                                        leadCubit.currentLeadDetail!.name ?? "",
                                    'id': leadCubit.currentLeadDetail!.id,
                                  },
                                );
                              },
                              child: Text(
                                "View Customer",
                                style: const TextStyle(
                                  fontSize: AppDimens.textSize14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2F96B4),
                                ),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        10.h,
                      ],
                    ),
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget contentRow({required String title, required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: AppDimens.textSize14,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimens.spacing8.w,
        Expanded(
          child: Text(
            data,
            style: const TextStyle(fontSize: AppDimens.textSize14),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  void onTakePhotoSelected({required BuildContext context}) {
    showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => TakeCustomerPhotoDialog(
        onSave: (file) {
          context.pop();

          context.read<LeadsCubit>().updateLeadPhoto(
            file: file,
            id:context.read<LeadsCubit>().currentLeadDetail?.customerId ?? "",
          );
        },
      ),
    );
  }

  void onSendEmailSelected({required BuildContext context}) {
    final currentLeadDetail = context.read<LeadsCubit>().currentLeadDetail;

    final subjectFocus = FocusNode();
    final messageFocus = FocusNode();
    
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SendEmailDialog(
        subjectController: subjectController, 
        messageController: messageController, 
        subjectFocus: subjectFocus, 
        messageFocus: messageFocus, 
        title: 'Send Email',
        onSend: () async{
          context.pop();
          await context.read<LeadsCubit>().sendEmail(
            custId: currentLeadDetail!.customerId!,
            subject: subjectController.text,
            message: messageController.text 
          );
        },
      ),
    );
  }

  
}
