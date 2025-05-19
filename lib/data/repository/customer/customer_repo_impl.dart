import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/customer/customer_repo.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final ApiService apiService;

  CustomerRepositoryImpl(this.apiService);

  @override
  Future<dynamic> getCustomers() async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'getCustomers',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getCustomerDetail(String id) async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'getCustomer',
          'id' : id,
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }
  
  @override
  Future<dynamic> editCustomerDetail({
    required String id, 
    required String name, 
    required String surname, 
    required String email, 
    required String phone, 
    required String country, 
    required String spouseName, 
    required String wifeEmail, 
    required String wifePhone
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'editCustomer',
          'token' : token
        },
        body: FormData.fromMap({
          'id': id,
          'name': name,
          'surname' : surname,
          'spouse_name' : spouseName,
          'email' : email,
          'wife_email' : wifeEmail,
          'country' : country,
          'phone' : phone,
          'wife_phone' : wifePhone,
        }),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> addCustomerDetail({
    required Map<String, String> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'addCustomer',
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
  Future<dynamic> searchCustomerDetail({
    required Map<String, String> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'searchCustomers',
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