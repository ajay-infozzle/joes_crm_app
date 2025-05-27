import 'package:joes_jwellery_crm/data/repository/task/task_repo.dart';

class TaskUsecase {
  final TaskRepository repository;
  TaskUsecase({required this.repository});

  Future<dynamic> fetchTaskList() {
    return repository.getTaskList();
  }

  Future<dynamic> fetchSingleTask({required Map<String, String> formdata}) {
    return repository.getSingleTask(formdata: formdata);
  }

  Future<dynamic> editTask({required Map<String, String> formdata}) {
    return repository.editTask(formdata: formdata);
  }
}
