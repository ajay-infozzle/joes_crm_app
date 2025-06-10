import 'package:joes_jwellery_crm/data/repository/report/report_repo.dart';

class ReportsUsecase {
  ReportRepository repository;
  ReportsUsecase(this.repository);

  Future<dynamic> fetchAllWaterTaxiReport() {
    return repository.getWaterTaxiReport();
  }

  Future<dynamic> deleteWaterTaxiReport({required String id}) {
    return repository.deleteWaterTaxiReport(id: id);
  }

  Future<dynamic> filterWaterTexiReport({
    required Map<String, dynamic> formdata,
  }) {
    return repository.filterWaterTaxiReport(formdata: formdata);
  }

  Future<dynamic> fetchAllAppraisalReport() {
    return repository.getAppraisalReport();
  }

  Future<dynamic> deleteAppraisalReport({required String id}) {
    return repository.deleteAppraisalReport(id: id);
  }

  Future<dynamic> filterAppraisalReport({
    required Map<String, dynamic> formdata,
  }) {
    return repository.filterAppraisalReport(formdata: formdata);
  }

}
