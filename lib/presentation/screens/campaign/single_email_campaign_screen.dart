import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/core/utils/helpers.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class SingleEmailCampaignScreen extends StatefulWidget {
  final String campgnId ;
  const SingleEmailCampaignScreen({super.key, required this.campgnId});

  @override
  State<SingleEmailCampaignScreen> createState() => _SingleEmailCampaignScreenState();
}

class _SingleEmailCampaignScreenState extends State<SingleEmailCampaignScreen> {

  @override
  void initState() {
    super.initState();

    context.read<EmailCubit>().fetchSingleEmailCampgn(id: widget.campgnId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Email Campaign",
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
      ),

      body: SafeArea(
        child: Container(
          width: width,
          color: AppColor.white,
          child: BlocConsumer<EmailCubit, EmailState>(
            listener: (context, state) {
              
            },
            builder: (context, state) {
              EmailCubit emailCubit = context.read<EmailCubit>();

              if (state is EmailCampLoading ) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  ),
                );
              } else if (state is EmailCampError) {
                return Expanded(
                  child: RetryWidget(
                    onTap: () async {
                      emailCubit.fetchSingleEmailCampgn(id: widget.campgnId);
                    },
                  ),
                );
              } else if (emailCubit.currentEmailCamp != null) {
                return ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(AppDimens.spacing10),
                      padding: const EdgeInsets.all(AppDimens.spacing10),
                      decoration: BoxDecoration(
                        color: AppColor.greenishGrey.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(AppDimens.radius12),
                      ),
                      child: RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          emailCubit.fetchSingleEmailCampgn(id: widget.campgnId);
                        },
                        child: Column(
                          children: [

                            contentRow(
                              title: "Title",
                              data: emailCubit.currentEmailCamp?.title ?? "_",
                            ),
                            10.h,
                    
                            contentRow(
                              title: "Status",
                              data: emailCubit.currentEmailCamp?.status ?? "_",
                            ),
                            10.h,
                    
                            
                    
                            contentRow(
                              title: "Created By",
                              data: "${getUser(context,emailCubit.currentEmailCamp?.createdBy ?? "_",)} - ${emailCubit.currentEmailCamp?.creationDate}",
                            ),
                            10.h,
                          ],
                        ),
                      ),
                    ),

                    20.h,
                    Container(
                      margin: const EdgeInsets.all(AppDimens.spacing10),
                      padding: EdgeInsets.all(AppDimens.spacing10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.primary,
                        ),
                        borderRadius: BorderRadius.circular(AppDimens.radius10)
                      ),
                      child: SelectableText(
                        emailCubit.currentEmailCamp?.text??"",
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
  
}