import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/exception/app_execption.dart';
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
  Future<dynamic> filterCustomers({required Map<String, dynamic> formdata}) async {
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'getCustomers',
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
  Future<dynamic> editCustomerDetail({required Map<String, dynamic> formdata}) async{
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
        body: FormData.fromMap(formdata),
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> addCustomerDetail({
    required Map<String, dynamic> formdata
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
  Future<dynamic> sendHimEmail({
    required Map<String, dynamic> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'sendHimEmail',
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
  Future<dynamic> sendHerEmail({
    required Map<String, dynamic> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'sendHerEmail',
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
  Future<dynamic> sendWaterTaxiEmail({
    required Map<String, dynamic> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'sendWaterTaxiEmail',
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
  Future<dynamic> sendApprCertEmail({
    required Map<String, dynamic> formdata
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'sendAppraisalCertificateEmail',
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
  Future<dynamic> updateCustomerPhoto({
    required File file,
    required String id,
  }) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'customers',
          'task' : 'takePhoto',
          'token' : token
        },
        body: FormData.fromMap(
          {
            'customer_id' : id,
            'photo' : await MultipartFile.fromFile(
              file.path, 
              filename: "${id}_${DateTime.now().millisecondsSinceEpoch}.jpg",
              contentType: MediaType('image', 'jpeg')
            )
          }
        ),
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

  @override
  Future<dynamic> validateEmail({
    required String email
  }) async{
    String apiKey = "ev-fb209d57b2cb2b86bfad13dd7e723be4";
    String url = "https://api.email-validator.net/api/verify";

    try {
      Dio dio = Dio();
      final response = await dio.post(
        url,
        data: FormData.fromMap({
          'EmailAddress' : email,
          'APIKey' : apiKey
        }),
      );

      if(response.statusCode == 200){
        return response.data;
      }else {
        throw FetchDataException('Something went wrong');
      }
    } catch (e) {
      rethrow ;
    }
  }
}