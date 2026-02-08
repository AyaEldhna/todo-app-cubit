part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  final List<TaskModel> tasklist;

  const TaskState(this.tasklist);

  @override
  List<Object?> get props => [tasklist];
}

final class TaskInitial extends TaskState {
  TaskInitial() : super([]);
}

final class UpdateTask extends TaskState {
  const UpdateTask(super.tasklist);
}
