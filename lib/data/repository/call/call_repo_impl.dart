import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/call/call_repo.dart';

class CallRepoImpl extends CallRepository {
  final ApiService apiService;

  CallRepoImpl(this.apiService);

  @override
  Future getCallLog() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'calllog',
          'task' : 'getCallLog',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }
}
