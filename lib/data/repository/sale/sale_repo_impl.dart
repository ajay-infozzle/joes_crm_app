import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/sale/sale_repo.dart';

class SaleRepoImpl implements SaleRepository{
  final ApiService apiService;
  SaleRepoImpl(this.apiService);

  @override
  Future<dynamic> addSale({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'addSale',
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
  Future<dynamic> deleteSale(String id) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'deleteSale',
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
  Future<dynamic> getSales() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'getSales',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> filterSales({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'getSales',
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
  Future<dynamic> getSingleSale(String id) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'getSale',
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
  Future<dynamic> updateSale({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'sales',
          'task' : 'editSale',
          'token' : token
        },
        body: FormData.fromMap(formdata),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}