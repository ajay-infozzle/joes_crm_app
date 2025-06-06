abstract class ReportRepository {
  Future<dynamic> getWaterTaxiReport();
  Future<dynamic> filterWaterTaxiReport({required Map<String, dynamic> formdata});
  Future<dynamic> getAppraisalReport();
  Future<dynamic> filterAppraisalReport({required Map<String, dynamic> formdata});
}