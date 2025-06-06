import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/date_formatter.dart';
import 'package:joes_jwellery_crm/core/utils/extensions.dart';
import 'package:joes_jwellery_crm/presentation/bloc/reports/reports_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/report_pie_chart.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/store_user_table.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/water_taxi_report_tile.dart';

class WaterTaxiReport extends StatefulWidget {
  const WaterTaxiReport({super.key});

  @override
  State<WaterTaxiReport> createState() => _WaterTaxiReportState();
}

class _WaterTaxiReportState extends State<WaterTaxiReport> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ReportsCubit>().fetchWaterTaxiReports();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<ReportsCubit, ReportsState>(
      listener: (context, state) {

      },
      builder: (context, state) {

        ReportsCubit reportsCubit = context.read<ReportsCubit>();

        if(state is WaterTaxiLoading){
          return Center(child: CircularProgressIndicator(color: AppColor.primary,));
        }
        if(state is WaterTaxiLoaded && reportsCubit.waterTaxiReports.isEmpty){
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
                    "Water Taxi Send Report: ${getDMY(reportsCubit.dateFrom)} - ${getDMY(reportsCubit.dateTo)}",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppDimens.textSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ReportPieChart(
                    value2: reportsCubit.waterTaxiValue2,
                    value4: reportsCubit.waterTaxiValue4,
                    value5: reportsCubit.waterTaxiValue5,
                  ),
                  10.h,

                  StoreUserTable(
                    summaries: reportsCubit.waterTaxiSummaryList,
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
                    itemCount: reportsCubit.waterTaxiReports.length,
                    itemBuilder: (context, index) {
                      return WaterTaxiReportTile(
                        report: reportsCubit.waterTaxiReports[index],
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
