
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo.dart';

class LeadsUseCase {
  final LeadsRepository repository;
  LeadsUseCase(this.repository);

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
}