import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/auth/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<dynamic> login(String username, String password) async {
    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'auth',
          'controller' : 'auth',
          'task' : 'login'
        },
        body: FormData.fromMap({
          'username': username,
          'password': password
        }),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }
}