import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/whatsapp/whatsapp_repo.dart';

class WhatsappRepoImpl extends WhatsappRepository{
  final ApiService apiService;

  WhatsappRepoImpl(this.apiService);
  
  @override
  Future getChatList() async{
    try {
      final sessionManager = SessionManager();
      String token = sessionManager.getToken() ?? "";
      
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'logs',
          'task' : 'getWhatsAppChats',
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
          'task' : 'getWhatsAppThread',
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