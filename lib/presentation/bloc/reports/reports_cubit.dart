import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/data/model/appraisal_report_model.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/store_list_model.dart';
import 'package:joes_jwellery_crm/data/model/water_taxi_report_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/reports_usecase.dart';
import 'package:joes_jwellery_crm/presentation/screens/report/widget/store_user_table.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final ReportsUsecase reportsUsecase;
  ReportsCubit({required this.reportsUsecase}) : super(ReportsInitial());

  List<WaterTaxiEmailReportData> waterTaxiReports = [];
  List<AppraisalCertificateEmailReport> appraisalReports = [];
  List<StoreUserSummary> waterTaxiSummaryList = [];
  List<StoreUserSummary> appraisalSummaryList = [];

  double waterTaxiValue2 = 0;
  double waterTaxiValue4 = 0;
  double waterTaxiValue5 = 0;
  double appraisalValue2 = 0;
  double appraisalValue4 = 0;
  double appraisalValue5 = 0;

  String dateFrom = '';
  String dateTo = '';
  String expiryFrom = '';
  String expiryTo = '';
  Stores? filterStore ;
  Users? filterUser ;

  Future<void> fetchWaterTaxiReports() async {
    try {
      emit(WaterTaxiLoading());
      final response = await reportsUsecase.fetchAllWaterTaxiReport();
      final data = WaterTaxiReportModel.fromJson(response);
      waterTaxiReports = data.waterTaxiEmailReportData ?? [] ;

      // Calculate percentages
      calculateWaterTaxiPercentage();
      waterTaxiSummaryList = summarizeWaterTaxiData(waterTaxiReports);

      emit(WaterTaxiLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(WaterTaxiError(e.toString()));
    }
  } 

  Future<void> deleteWaterTaxiReport({required String id}) async {
    try {
      emit(WaterTaxiLoading());
      final response = await reportsUsecase.deleteWaterTaxiReport(id: id);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        fetchWaterTaxiReports();
      }else{
        emit(WaterTaxiError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(WaterTaxiError(e.toString()));
    }
  } 
  

  Future<void> filterWaterTaxiReports() async {
    try {
      emit(WaterTaxiLoading());
      final response = await reportsUsecase.filterWaterTexiReport(
        formdata: {
          'date_from' : dateFrom,
          'date_to' : dateTo,
          'date_month' : '',
          'expire_from' : expiryFrom,
          'expire_to' : expiryTo,
          'store_id' : filterStore?.id ?? '',
          'user_id' : filterUser?.id ?? ''
        }
      );
      final data = WaterTaxiReportModel.fromJson(response);
      waterTaxiReports = data.waterTaxiEmailReportData ?? [] ;

      calculateWaterTaxiPercentage();
      waterTaxiSummaryList = summarizeWaterTaxiData(waterTaxiReports);
      
      // dateFrom = '' ; 
      // dateTo  =  '' ;
      expiryFrom = '' ;
      expiryTo = '';
      filterStore = null ;
      filterUser = null ;

      emit(WaterTaxiLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(WaterTaxiError(e.toString()));
    }
  } 

  void calculateWaterTaxiPercentage(){
    // Calculate percentages
    final totalCount = waterTaxiReports.length;
    if (totalCount > 0) {
      final count2 = waterTaxiReports.where((e) => e.storeId == '1').length;
      final count4 = waterTaxiReports.where((e) => e.storeId == '2').length;
      final count5 = waterTaxiReports.where((e) => e.storeId == '3').length;

      waterTaxiValue2 = double.parse(((count2 / totalCount) * 100).toStringAsFixed(1));
      waterTaxiValue4 = double.parse(((count4 / totalCount) * 100).toStringAsFixed(1));
      waterTaxiValue5 = double.parse(((count5 / totalCount) * 100).toStringAsFixed(1));

    } else {
      waterTaxiValue2 = 0;
      waterTaxiValue4 = 0;
      waterTaxiValue5 = 0;
    }
  }

  List<StoreUserSummary> summarizeWaterTaxiData(List<WaterTaxiEmailReportData> dataList) {
    final Map<String, Map<String, int>> userStoreMap = {};

    for (final data in dataList) {
      final user = data.createdBy ?? 'Unknown';
      final store = data.storeId ?? 'Unknown';

      userStoreMap.putIfAbsent(user, () => {});
      userStoreMap[user]!.update(store, (count) => count + 1, ifAbsent: () => 1);
    }

    return userStoreMap.entries.map((entry) {
      return StoreUserSummary(userId: entry.key, storeCounts: entry.value);
    }).toList();
  }

  Future<void> fetchAppraisalReports() async {
    try {
      emit(AppraisalLoading());
      final response = await reportsUsecase.fetchAllAppraisalReport();
      final data = AppraisalReportModel.fromJson(response);
      appraisalReports = data.appraisalCertificateEmailReport ?? [] ;

      calculateAppraisalReportPercentage();
      appraisalSummaryList = summarizeAppraisalData(appraisalReports);

      emit(AppraisalLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(AppraisalError(e.toString()));
    }
  } 

  Future<void> deleteAppraisalReport({required String id}) async {
    try {
      emit(AppraisalLoading());
      final response = await reportsUsecase.deleteAppraisalReport(id: id);
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        fetchAppraisalReports();
      }else{
        emit(AppraisalError("Something went wrong !"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(AppraisalError(e.toString()));
    }
  } 

  Future<void> filterAppraisalReports() async {
    try {
      emit(AppraisalLoading());
      final response = await reportsUsecase.filterAppraisalReport(
        formdata: {
          'date_from' : dateFrom,
          'date_to' : dateTo,
          'date_month' : '',
          'store_id' : filterStore?.id ?? '',
          'user_id' : filterUser?.id ?? ''
        }
      );
      final data = AppraisalReportModel.fromJson(response);
      appraisalReports = data.appraisalCertificateEmailReport ?? [] ;

      calculateAppraisalReportPercentage();
      appraisalSummaryList = summarizeAppraisalData(appraisalReports);
      
      // dateFrom = '' ; 
      // dateTo  =  '' ;
      filterStore = null ;
      filterUser = null ;

      emit(AppraisalLoaded());
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Reports Cubit");
      emit(AppraisalError(e.toString()));
    }
  } 

  void calculateAppraisalReportPercentage(){
    // Calculate percentages
    final totalCount = appraisalReports.length;
    if (totalCount > 0) {
      final count2 = appraisalReports.where((e) => e.storeId == '1').length;
      final count4 = appraisalReports.where((e) => e.storeId == '2').length;
      final count5 = appraisalReports.where((e) => e.storeId == '3').length;

      appraisalValue2 = double.parse(((count2 / totalCount) * 100).toStringAsFixed(1));
      appraisalValue4 = double.parse(((count4 / totalCount) * 100).toStringAsFixed(1));
      appraisalValue5 = double.parse(((count5 / totalCount) * 100).toStringAsFixed(1));

    } else {
      appraisalValue2 = 0;
      appraisalValue4 = 0;
      appraisalValue5 = 0;
    }
  }

  List<StoreUserSummary> summarizeAppraisalData(List<AppraisalCertificateEmailReport> dataList) {
    final Map<String, Map<String, int>> userStoreMap = {};

    for (final data in dataList) {
      final user = data.createdBy ?? 'Unknown';
      final store = data.storeId ?? 'Unknown';

      userStoreMap.putIfAbsent(user, () => {});
      userStoreMap[user]!.update(store, (count) => count + 1, ifAbsent: () => 1);
    }

    return userStoreMap.entries.map((entry) {
      return StoreUserSummary(userId: entry.key, storeCounts: entry.value);
    }).toList();
  }

}
