part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}
final class TaskListLoading extends TaskState {}
final class TaskLoading extends TaskState {}

final class TaskEditFormLoading extends TaskState {}
final class TaskEditFormUpdate extends TaskState {}
final class TaskEditFormUpdated extends TaskState {}

class TaskListLoaded extends TaskState {
  final List<Tasks> tasks;
  const TaskListLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
class TaskLoaded extends TaskState {
  final Task task;
  const TaskLoaded(this.task);

  @override
  List<Object> get props => [task];
}

class TaskListError extends TaskState {
  final String message;
  const TaskListError(this.message);

  @override
  List<Object> get props => [message];
}
class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
class TaskEditFormError extends TaskState {
  final String message;
  const TaskEditFormError(this.message);

  @override
  List<Object> get props => [message];
}