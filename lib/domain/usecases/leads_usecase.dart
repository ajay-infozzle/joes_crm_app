
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo.dart';

class LeadsUseCase {
  final LeadsRepository repository;
  LeadsUseCase(this.repository);

  Future<dynamic> getAllLeads() {
    return repository.getAllLeads();
  }

  Future<dynamic> searchLeads({
    required Map<String, String> query,
  }) {
    return repository.searchLeads(query: query);
  }

  Future<dynamic> addLeads({
    required Map<String, String> formdata,
  }) {
    return repository.addLeads(formdata: formdata);
  }

  Future<dynamic> updateLeads({
    required Map<String, String> formdata,
  }) {
    return repository.updateLeads(formdata: formdata);
  }

  Future<dynamic> getLeadDetail({
    required Map<String, String> formdata,
  }) {
    return repository.getLeadDetail(formdata: formdata);
  }
}