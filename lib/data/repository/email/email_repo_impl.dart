import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/email/email_repo.dart';

class EmailRepoImpl implements EmailRepository{
  final ApiService apiService ;
  EmailRepoImpl(this.apiService);

  @override
  Future<dynamic> addEmailTemp({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'emailtpls',
          'task' : 'addEmailTpl',
          'token' : token
        },
        body: FormData.fromMap(formdata)
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> deleteEmailTemp({required String id}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'emailtpls',
          'task' : 'deleteEmailTpl',
          'token' : token
        },
        body: FormData.fromMap({'id' : id})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> fetchEmailTemps() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'emailtpls',
          'task' : 'getEmailTpls',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> fetchSingleEmailTemp({required String id}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'emailtpls',
          'task' : 'getEmailTpl',
          'token' : token
        },
        body: FormData.fromMap({'id' : id})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> updateEmailTemp({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'emailtpls',
          'task' : 'editEmailTpl',
          'token' : token
        },
        body: FormData.fromMap(formdata)
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }


  @override
  Future<dynamic> fetchEmailCampgns() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'emailcampaigns',
          'task' : 'getEmailCampaigns',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> fetchSingleEmailCampgns({required String id}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'emailcampaigns',
          'task' : 'getEmailCampaign',
          'token' : token
        },
        body: FormData.fromMap({'id' : id})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}