abstract class ReportRepository {
  Future<dynamic> getWaterTaxiReport();
  Future<dynamic> deleteWaterTaxiReport({required String id});
  Future<dynamic> filterWaterTaxiReport({required Map<String, dynamic> formdata});
  Future<dynamic> getAppraisalReport();
  Future<dynamic> deleteAppraisalReport({required String id});
  Future<dynamic> filterAppraisalReport({required Map<String, dynamic> formdata});
}