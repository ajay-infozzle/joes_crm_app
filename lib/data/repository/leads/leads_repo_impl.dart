import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/leads/leads_repo.dart';

class LeadsRepoImpl implements LeadsRepository{
  final ApiService apiService;

  LeadsRepoImpl(this.apiService);

  @override
  Future<dynamic> addLeads({required Map<String, String> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'leads',
          'task' : 'addLead',
          'token' : token
        },
        body: FormData.fromMap(formdata),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> updateLeads({required Map<String, String> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'leads',
          'task' : 'editLead',
          'token' : token
        },
        body: FormData.fromMap(formdata),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getLeadDetail({required Map<String, String> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'leads',
          'task' : 'getLead',
          'token' : token
        },
        body: FormData.fromMap(formdata),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> searchLeads({required Map<String, String> query}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'leads',
          'task' : 'searchLeads',
          'token' : token
        },
        body: FormData.fromMap(query),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getAllLeads() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'leads',
          'task' : 'getLeads',
          'token' : token
        },
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}