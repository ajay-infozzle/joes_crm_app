abstract class LeadsRepository {
  Future<dynamic> searchLeads({
    required Map<String, String> query,
  });
  Future<dynamic> addLeads({
    required Map<String, String> formdata,
  });
}