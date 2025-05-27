import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/session_manager.dart';
import 'package:joes_jwellery_crm/data/network/api_service.dart';
import 'package:joes_jwellery_crm/data/repository/task/task_repo.dart';

class TaskRepoImpl extends TaskRepository{
  final ApiService apiService ;
  TaskRepoImpl({required this.apiService});

  @override
  Future<dynamic> editTask({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'tasks',
          'task' : 'editTask',
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
  Future<dynamic> getSingleTask({required Map<String, dynamic> formdata}) async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.post(
        '',
        queryParams: {
          'view' : 'tasks',
          'task' : 'getTask',
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
  Future<dynamic> getTaskList() async{
    final sessionManager = SessionManager();
    String token = sessionManager.getToken() ?? "";

    try {
      final response = await apiService.get(
        '',
        queryParams: {
          'view' : 'tasks',
          'task' : 'getTasks',
          'token' : token
        }
      );
      
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}