import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/home/home_repo.dart';


class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
  Future<dynamic> fetch() async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'home',
          'task' : 'getPhoneLogs',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getStores() async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'stores',
          'task' : 'getStores',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getUsers({required bool isSalesAssoc}) async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'users',
          'task' : 'getUsers',
          'token' : token
        },
        body: FormData.fromMap({
          'type': isSalesAssoc ? 'sales' : '',
        })
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }
}