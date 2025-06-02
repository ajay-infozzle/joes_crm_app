import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/free_item/free_item_repo.dart';

class FreeItemRepoImpl implements FreeItemRepository{
  final ApiService apiService ;
  FreeItemRepoImpl(this.apiService);

  @override
  Future<dynamic> addFreeItem({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'freeitems',
          'task' : 'addItem',
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
  Future<dynamic> deleteSingleFreeItem({required String itemId}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'freeitems',
          'task' : 'deleteItem',
          'token' : token
        },
        body: FormData.fromMap({'id' : itemId})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> editFreeItem({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'freeitems',
          'task' : 'editItem',
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
  Future<dynamic> getAllFreeItems() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'freeitems',
          'task' : 'getItems',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

  @override
  Future<dynamic> getSingleFreeItem({required String itemId}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'freeitems',
          'task' : 'getItem',
          'token' : token
        },
        body: FormData.fromMap({'id' : itemId})
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}