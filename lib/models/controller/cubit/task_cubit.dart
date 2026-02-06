import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usma_elgendy_bloc/models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  // ignore: strict_top_level_inference
  addTask(TaskModel model) {
    emit(UpdateTask([...state.tasklist, model]));
    //   emit(UpdateTask(List.from(state.tasklist)..add(model))); Poth are good we can use poth
  }

  // ignore: strict_top_level_inference
  removeTask(String id) {
    final List<TaskModel> newList = state.tasklist
        // ignore: unrelated_type_equality_checks
        .where((task) => task.id != id)
        .toList();
    emit(UpdateTask(newList));
  }

  // ignore: strict_top_level_inference
  toggleTask(String id) {
    final List<TaskModel> newList = state.tasklist.map((task) {
      // ignore: unrelated_type_equality_checks
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(UpdateTask(newList));
  }
}
