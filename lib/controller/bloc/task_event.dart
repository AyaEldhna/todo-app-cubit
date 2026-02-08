import 'package:usma_elgendy_bloc/models/task_model.dart';

sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskModel model;

  AddTaskEvent(this.model);
}

class RemoveTaskEvent extends TaskEvent {
  final String id;

  RemoveTaskEvent(this.id);
}

class ToggleTaskEvent extends TaskEvent {
  final String id;

  ToggleTaskEvent(this.id);
}
