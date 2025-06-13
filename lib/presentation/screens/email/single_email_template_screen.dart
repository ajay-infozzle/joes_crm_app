import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/bloc/home/home_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class SingleEmailTemplateScreen extends StatefulWidget {
  final String tempId;
  const SingleEmailTemplateScreen({super.key, required this.tempId});

  @override
  State<SingleEmailTemplateScreen> createState() => _SingleEmailTemplateScreenState();
}

class _SingleEmailTemplateScreenState extends State<SingleEmailTemplateScreen> {

  @override
  void initState() {
    super.initState();

    context.read<EmailCubit>().currentEmailTempl = null ;
    context.read<EmailCubit>().fetchSingleEmailTemplate(id: widget.tempId);
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
            "Email Template",
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
                  RoutesName.editEmailTemplateScreen,
                  extra: context.read<EmailCubit>().currentEmailTempl,
                );
              } else if (value == 'delete') {
                context.read<EmailCubit>().deleteEmailTemplate(id: widget.tempId);
                // showAppSnackBar(context, message: "Coming soon !");
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
                ],
          ),
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<EmailCubit, EmailState>(
            listener: (context, state) {
              if(state is EmailTemplDeleted){
                context.pop();
              }
            },
            builder: (context, state) {
              EmailCubit emailCubit = context.read<EmailCubit>();
          
              if (state is EmailTemplDetailLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColor.primary),
                );
              } else if (state is EmailTemplDetailError) {
                return Center(
                  child: RetryWidget(
                    onTap: () async {
                      context.read<EmailCubit>().fetchSingleEmailTemplate(id: widget.tempId);
                    },
                  ),
                );
              } else if (emailCubit.currentEmailTempl != null) {
                final createdBy = getUserName(emailCubit.currentEmailTempl?.createdBy??"");
                final creationDate = formatDateTime(emailCubit.currentEmailTempl?.creationDate??"");
          
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.spacing15),
                  children: [
                    10.h,
          
                    rowContent("Title", emailCubit.currentEmailTempl?.title??""),
                    5.h,
                    rowContent("Subject", emailCubit.currentEmailTempl?.subject??""),
                    5.h,
                    rowContent("Type", emailCubit.currentEmailTempl?.type??""),
                    5.h,
                    rowContent("Created by", "$createdBy - ${creationDate['date']} ${creationDate['time']}"),
                    25.h,
          
                    Container(
                      padding: EdgeInsets.all(AppDimens.spacing10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.primary,
                        ),
                        borderRadius: BorderRadius.circular(AppDimens.radius10)
                      ),
                      child: SelectableText(
                        emailCubit.currentEmailTempl?.content??"",
                        style: TextStyle(
                          fontSize: AppDimens.textSize14, 
                          color: AppColor.primary
                        ),
                      ),
                    ),
                  ],
                );
              }
          
              return SizedBox();
            },
          ),
        ) 
      ),
    );
  }

  Widget rowContent(String title, String value){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDimens.textSize16, color: AppColor.primary),
          ), 
        ),
       
        5.w,

        Expanded(
          flex: 4,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: AppDimens.textSize14,color: AppColor.primary),
          ), 
        ),
      ],
    );
  }
}