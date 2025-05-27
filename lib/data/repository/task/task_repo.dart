abstract class TaskRepository {
  Future<dynamic> getTaskList();
  Future<dynamic> getSingleTask({required Map<String, dynamic> formdata});
  Future<dynamic> editTask({required Map<String, dynamic> formdata});
}