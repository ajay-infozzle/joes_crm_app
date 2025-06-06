import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';
import 'package:joes_jwellery_crm/core/utils/assets_constant.dart';
import 'package:joes_jwellery_crm/presentation/bloc/reports/reports_cubit.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/appraisal_report.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/report_filter_dialog.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/water_taxi_report.dart';

 
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
 
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}
 
class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  late TabController _tabController;
 
  @override
  void initState() {
    super.initState();
 
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    updateDateFromAndTo();
  }

  void updateDateFromAndTo(){
    final now = DateTime.now();
    final oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    context.read<ReportsCubit>().dateFrom = DateFormat('yyyy-MM-dd').format(oneMonthAgo);
    context.read<ReportsCubit>().dateTo = DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  bool get wantKeepAlive => true;
 
  @override
  Widget build(BuildContext context) {
    super.build(context);
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Reports", style: TextStyle(color: AppColor.white),),
        scrolledUnderElevation: 0,
        foregroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.white,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AssetsConstant.filterIcon,
              width: AppDimens.icon18,
              height: AppDimens.icon18,
              color: AppColor.white,
            ),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => ReportFilterDialog(
                  index: _tabController.index,
                  onSearch: () {
                    if(_tabController.index == 0){
                      context.read<ReportsCubit>().filterWaterTaxiReports();
                    }else{
                      context.read<ReportsCubit>().filterAppraisalReports();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
 
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColor.primary,
            indicatorSize: TabBarIndicatorSize.tab,    
            dividerColor: AppColor.primary.withValues(alpha:.2),
            indicatorWeight: 1,     
            tabs: [
              Tab(
                child:Text(
                  "Water Taxi",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    fontWeight: FontWeight.bold,
                    color:AppColor.primary,
                  ),
                ),
              ),
              Tab(
                child: Text(
                   "Appraisal Cirtificate",
                    style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    fontWeight: FontWeight.bold,
                    color:AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
      
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const[
                WaterTaxiReport(),
                AppraisalReport(),     
              ],
            ),
          ),
        ],
      ),
    );
  }
}