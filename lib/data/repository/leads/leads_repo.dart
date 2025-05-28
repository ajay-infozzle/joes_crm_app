abstract class LeadsRepository {
  Future<dynamic> getAllLeads();
  Future<dynamic> searchLeads({
    required Map<String, String> query,
  });
  Future<dynamic> addLeads({
    required Map<String, String> formdata,
  });
  Future<dynamic> updateLeads({
    required Map<String, String> formdata,
  });
  Future<dynamic> getLeadDetail({
    required Map<String, String> formdata,
  });
}