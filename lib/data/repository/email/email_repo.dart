abstract class EmailRepository {
  Future<dynamic> fetchEmailTemps(); 
  Future<dynamic> fetchSingleEmailTemp({required String id}); 
  Future<dynamic> deleteEmailTemp({required String id}); 
  Future<dynamic> addEmailTemp({required Map<String, dynamic> formdata}); 
  Future<dynamic> updateEmailTemp({required Map<String, dynamic> formdata}); 
} 