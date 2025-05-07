import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/sms/sms_repo.dart';

class SmsRepoImpl extends SmsRepository{
  final ApiService apiService;

  SmsRepoImpl(this.apiService);
  
  @override
  Future getChatList() async{
    try {
      final sessionManager = SessionManager();
      String token = sessionManager.getToken() ?? "";
      
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'logs',
          'task' : 'getSMSChats',
          'token' : token
        },
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future getChatThread({required String chatId}) async{
    try {
      final sessionManager = SessionManager();
      String token = sessionManager.getToken() ?? "";

      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'logs',
          'task' : 'getSMSThread',
          'token' : token
        },
        body: FormData.fromMap({
          'chat_id': chatId
        }),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}