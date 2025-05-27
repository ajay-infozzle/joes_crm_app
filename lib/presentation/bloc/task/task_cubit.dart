import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joes_jwellery_crm/core/theme/colors.dart';
import 'package:joes_jwellery_crm/data/model/assoc_list_model.dart';
import 'package:joes_jwellery_crm/data/model/single_task_model.dart';
import 'package:joes_jwellery_crm/data/model/task_list_model.dart';
import 'package:joes_jwellery_crm/domain/usecases/task_usecase.dart';
import 'package:joes_jwellery_crm/presentation/widgets/app_snackbar.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskUsecase taskUsecase;
  TaskCubit({required this.taskUsecase}) : super(TaskInitial());

  Users? currentTaskUser ;
  Task? currentTask ;

  void changeUser(Users value){
    currentTaskUser = value;
    emit(TaskEditFormUpdate());
  }

  Future<void> fetchTaskList() async {
    try {
      emit(TaskListLoading());
      final response = await taskUsecase.fetchTaskList();
      final data = TaskListModel.fromJson(response);
      emit(TaskListLoaded(data.tasks??[]));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Task Cubit");
      emit(TaskListError(e.toString()));
    }
  }

  Future<void> fetchTaskDetail({required String id}) async {
    try {
      emit(TaskLoading());
      final response = await taskUsecase.fetchSingleTask(formdata: {"id" : id});
      final data = SingleTaskModel.fromJson(response);
      currentTask = data.task ;
      emit(TaskLoaded(data.task!));
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Task Cubit");
      emit(TaskError(e.toString()));
    }
  }

  Future<void> validateEditFormAndSubmit({required String title, required String dueDate, required String description}) async {
    try {
      emit(TaskEditFormLoading());
      final response = await taskUsecase.editTask(formdata: {
        "id" : currentTask?.id ?? "",
        "title" : title,
        "user_id" : currentTaskUser?.id ?? "",
        "due_date" : dueDate,
        "description" : description
      });
      
      if(response != null){
        showToast(msg: response['message'], backColor: AppColor.green);
        
        emit(TaskEditFormUpdated());
      }else{
        emit(TaskEditFormError("Something went wrong"));
      }
    } catch (e) {
      log("Error >> ${e.toString()}", name: "Task Cubit");
      emit(TaskEditFormError(e.toString()));
    }
  }
}
