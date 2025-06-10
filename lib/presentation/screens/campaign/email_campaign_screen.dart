import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/email_camp_list_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/campaign/widget/email_campaign_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class EmailCampaignScreen extends StatefulWidget {
  const EmailCampaignScreen({super.key});

  @override
  State<EmailCampaignScreen> createState() => _EmailCampaignScreenState();
}

class _EmailCampaignScreenState extends State<EmailCampaignScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFousNode = FocusNode();
  List<Emailcampaigns> filteredCampgns = [];

  @override
  void initState() {
    super.initState();

    context.read<EmailCubit>().fetchAllEmailCampaign();
  }

  void filterSearch(String query) {
    final allCampgns = context.read<EmailCubit>().allEmailCampgns;

    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredCampgns = allCampgns.where((campgn) {
        final id = (campgn.id ?? '').toLowerCase();
        final title = (campgn.title ?? '').toLowerCase();
        
        return id.contains(lowerQuery) ||
            title.contains(lowerQuery) ;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          "Email Campaigns",
          style: TextStyle(
            fontSize: AppDimens.textSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Container(
          width:  width,
          color: AppColor.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: TextField(
                  controller: searchController,
                  onChanged: filterSearch,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.spacing15,
                      ),
                      child: SizedBox(
                        width: AppDimens.icon13,
                        height: AppDimens.icon13,
                        child: Image.asset(
                          AssetsConstant.searchIcon,
                          color: AppColor.primary.withValues(alpha: .8),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    hintText: "title",
                    hintStyle: TextStyle(
                      color: AppColor.primary.withValues(alpha: .8),
                    ),
                    filled: true,
                    fillColor: AppColor.greenishGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppDimens.spacing5,
                    ),
                  ),
                  cursorColor: AppColor.primary,
                ),
              ),

              Expanded(
                child: BlocConsumer<EmailCubit, EmailState>(
                  listener: (context, state) {
                    if(state is EmailCampLoaded){
                      filteredCampgns = context.read<EmailCubit>().allEmailCampgns ;
                    }
                  },
                  builder: (context, state) {
                    EmailCubit emailCubit = context.read<EmailCubit>();

                    if (state is EmailCampLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is EmailCampError) {
                      return RetryWidget(
                        onTap: () async{
                          emailCubit.fetchAllEmailCampaign();
                        },
                      );
                    }
                    else if (emailCubit.allEmailCampgns.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          emailCubit.fetchAllEmailCampaign();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredCampgns.length,
                          itemBuilder: (context, index) {
                            return EmailCampaignTile(campgn: filteredCampgns[index]);
                          },
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  },
                ) ,
              ),
            ],
          ),
        ) 
      ),
    );
  }
  
}