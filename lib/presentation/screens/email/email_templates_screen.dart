import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joes_jwellery_crm/core/routes/routes_name.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/data/model/email_templates_model.dart';
import 'package:joes_jwellery_crm/presentation/bloc/email/email_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/email/widget/email_templates_tile.dart';
import 'package:joes_jwellery_crm/presentation/widgets/retry_widget.dart';

class EmailTemplatesScreen extends StatefulWidget {
  const EmailTemplatesScreen({super.key});

  @override
  State<EmailTemplatesScreen> createState() => _EmailTemplatesScreenState();
}

class _EmailTemplatesScreenState extends State<EmailTemplatesScreen> {

  final TextEditingController searchController = TextEditingController();
  List<Emailtpls> filteredTemplates = [];

  @override
  void initState() {
    super.initState();
    context.read<EmailCubit>().fetchAllEmailTemplates().then((_) {
      setState(() {
        filteredTemplates = List.from(context.read<EmailCubit>().allEmailTemplates);
      });
    });
  }

  void filterSearch(String query) {
    final allTemplates = context.read<EmailCubit>().allEmailTemplates;

    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredTemplates = allTemplates.where((template) {
        final title = (template.title ?? '').toLowerCase();
        final type = (template.type ?? '').toLowerCase();
        final approved = template.approved == '1' ? 'yes' : 'no';

        return title.contains(lowerQuery) ||
            type.contains(lowerQuery) ||
            approved.contains(lowerQuery);
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
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
        title: SizedBox(
          child: Text(
            "Email Templates",
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
              context.pushNamed(RoutesName.addEmailTemplateScreen);
            },
          ),
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: width,
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
                    hintText: "type, approved (Yes/No), title",
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
                    // if(state is EmailTemplDetailLoaded || state is EmailTemplDeleted){
                    //   setState(() {
                    //     filteredTemplates = List.from(context.read<EmailCubit>().allEmailTemplates);
                    //   });
                    // }
                  },
                  builder: (context, state) {
                    EmailCubit emailCubit = context.read<EmailCubit>();

                    if (state is EmailTempsLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColor.primary));
                    }
                    else if (state is EmailTempsError) {
                      return RetryWidget(
                        onTap: () async{
                          context.read<EmailCubit>().fetchAllEmailTemplates();
                        },
                      );
                    }
                    else if (emailCubit.allEmailTemplates.isNotEmpty) {
                      return RefreshIndicator(
                        color: AppColor.primary,
                        onRefresh: () async {
                          emailCubit.fetchAllEmailTemplates();
                        },
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spacing15,
                            vertical: AppDimens.spacing8,
                          ),
                          itemCount: filteredTemplates.length,
                          itemBuilder: (context, index) {
                            return EmailTemplatesTile(
                              template : filteredTemplates[index],
                              onView: () {
                                context.pushNamed(RoutesName.singleEmailTemplateScreen, extra: filteredTemplates[index].id);
                              },
                            );
                          },
                        ),
                      );
                    }
                    else {
                      return SizedBox();
                    }
                  },
                )
              ),
            ],
          ),
        ) 
      ),
    );
  }
}