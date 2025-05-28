import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/leads/leads_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/widget/leads_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/screens/leads/widget/leads_search_list_widget.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

class SearchLeadScreen extends StatefulWidget {
  const SearchLeadScreen({super.key});

  @override
  State<SearchLeadScreen> createState() => _SearchLeadScreenState();
}

class _SearchLeadScreenState extends State<SearchLeadScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFousNode = FocusNode();


  @override
  void initState() {
    super.initState();
  
    context.read<LeadsCubit>().currentSearchLeads.clear();
    context.read<LeadsCubit>().getAllLeads();
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
          // width: width * 0.33,
          child: Text(
            "Search Leads",
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
          IconButton(
            icon: Icon(
              Icons.add,
              size: AppDimens.icon25,
              color: AppColor.primary,
            ),
            onPressed: () {
              context.pushNamed(RoutesName.addLeadsScreen);
            },
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
              if(state is LeadsSearchError){
                showAppSnackBar(context, message: state.message);
              }
            },
            builder: (context, state) {
              if(state is LeadsSearching){
                return Center(child: CircularProgressIndicator(color: AppColor.primary,),);
              }

              return Column(
                children: [
                  10.h,
                  Container(
                    height: AppDimens.spacing45,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.spacing10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            focusNode: searchFousNode,
                            onTapUpOutside: (event) => searchFousNode.unfocus(),
                            onChanged: (value) {
                              context.read<LeadsCubit>().onChangeSearchText(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search name, surname, email",
                              hintStyle: TextStyle(
                                color: AppColor.primary.withValues(alpha: .8),
                              ),
                              filled: true,
                              fillColor: AppColor.greenishGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radius12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: AppDimens.spacing5,
                                horizontal: AppDimens.spacing10,
                              ),
                            ),
                            cursorColor: AppColor.primary,
                          ),
                        ),
                        10.w,

                        Container(
                          decoration: BoxDecoration(
                            color:context.read<LeadsCubit>().currentSearchText.isNotEmpty ? AppColor.primary : AppColor.greenishGrey ,
                            borderRadius: BorderRadius.circular(
                              AppDimens.radius12,
                            ),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              AssetsConstant.searchIcon,
                              color: context.read<LeadsCubit>().currentSearchText.isNotEmpty ?AppColor.white : AppColor.primary,
                              height: AppDimens.spacing20,
                              width: AppDimens.spacing20,
                              fit: BoxFit.contain,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();

                              if(searchController.text.isNotEmpty){
                                context.read<LeadsCubit>().searchLeads();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  10.h,

                  Builder(
                    builder: (context) {
                      if(context.read<LeadsCubit>().currentSearchLeads.isNotEmpty && searchController.text.isNotEmpty){
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacing12),
                            child: ListView.builder(
                              itemCount: context.read<LeadsCubit>().currentSearchLeads.length,
                              itemBuilder:  (context, index) {
                                return LeadsSearchListWidget(leads: context.read<LeadsCubit>().currentSearchLeads[index]);
                              },
                            ),
                          ) 
                        );
                      }
                      else if(context.read<LeadsCubit>().currentSearchLeads.isEmpty && searchController.text.isNotEmpty){
                        return Expanded(
                          child: Center(
                            child: Text(
                              "Empty Leads",
                              style: TextStyle(
                                color: AppColor.primary.withValues(alpha: .7),
                                fontSize: AppDimens.textSize14
                              ),
                            ),
                          ),
                        );
                      }
                      else if(context.read<LeadsCubit>().allLeads.isNotEmpty){
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacing12),
                            child: RefreshIndicator(
                              color: AppColor.primary,
                              onRefresh: () => context.read<LeadsCubit>().getAllLeads(),
                              child: ListView.builder(
                                itemCount: context.read<LeadsCubit>().allLeads.length,
                                itemBuilder:  (context, index) {
                                  return LeadsListWidget(leads: context.read<LeadsCubit>().allLeads[index]);
                                },
                              ),
                            ),
                          ) 
                        );
                      }else{
                        return Expanded(
                          child: Center(
                            child: Text(
                              "Empty Leads",
                              style: TextStyle(
                                color: AppColor.primary.withValues(alpha: .7),
                                fontSize: AppDimens.textSize14
                              ),
                            ),
                          ),
                        );
                      }
                    }, 
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
