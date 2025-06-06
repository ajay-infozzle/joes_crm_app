import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/reports/reports_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/appraisal_report_tile.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/report_pie_chart.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/store_user_table.dart';

class AppraisalReport extends StatefulWidget {
  const AppraisalReport({super.key});

  @override
  State<AppraisalReport> createState() => _AppraisalReportState();
}

class _AppraisalReportState extends State<AppraisalReport> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ReportsCubit>().fetchAppraisalReports();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<ReportsCubit, ReportsState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {

        ReportsCubit reportsCubit = context.read<ReportsCubit>();

        if(state is AppraisalLoading){
          return Center(child: CircularProgressIndicator(color: AppColor.primary,));
        }
        if(state is AppraisalLoaded && reportsCubit.appraisalReports.isEmpty){
          return Center(
            child: Text(
              "No Reports Found",
              style: TextStyle(
                color: AppColor.primary.withValues(alpha: .5)
              ),
            ),
          );
        }

        return Container(
          color: AppColor.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: AppDimens.spacing15,
              right: AppDimens.spacing15,
              top: AppDimens.spacing2,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.h,
                  Text(
                    "Appraisal Certificate Send Report: ${getDMY(reportsCubit.dateFrom)} - ${getDMY(reportsCubit.dateTo)}",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  ReportPieChart(
                    value2: reportsCubit.appraisalValue2,
                    value4: reportsCubit.appraisalValue4,
                    value5: reportsCubit.appraisalValue5,
                  ),
                  10.h,
              
                  StoreUserTable(
                    summaries: reportsCubit.appraisalSummaryList,
                  ),
                  20.h,
              
                  Text(
                    "Delete report data",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  15.h,
              
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reportsCubit.appraisalReports.length,
                    itemBuilder: (context, index) {
                      return AppraisalReportTile(
                        report: reportsCubit.appraisalReports[index],
                      );
                    },
                  ),
                  20.h,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
