import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usma_elgendy_bloc/controller/bloc/task_event.dart';
import 'package:usma_elgendy_bloc/models/task_model.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      emit(UpdateTask([...state.tasklist, event.model]));
    });

    on<RemoveTaskEvent>((event, emit) {
      final List<TaskModel> newList = state.tasklist
          // ignore: unrelated_type_equality_checks
          .where((task) => task.id != event.id)
          .toList();
      emit(UpdateTask(newList));
    });

    on<ToggleTaskEvent>((event, emit) {
       final List<TaskModel> newList = state.tasklist.map((task) {
      // ignore: unrelated_type_equality_checks
      return task.id == event.id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(UpdateTask(newList));
    });
  }

  // /////////////////////////////////

  // ignore: strict_top_level_inference
  // addTask(TaskModel model) {
  //   emit(UpdateTask([...state.tasklist, model]));
  //   //   emit(UpdateTask(List.from(state.tasklist)..add(model))); Poth are good we can use poth
  // }

  // ignore: strict_top_level_inference
  // removeTask(String id) {
  //   final List<TaskModel> newList = state.tasklist
  //       // ignore: unrelated_type_equality_checks
  //       .where((task) => task.id != id)
  //       .toList();
  //   emit(UpdateTask(newList));
  // }

  // ignore: strict_top_level_inference
  // toggleTask(String id) {
  //   final List<TaskModel> newList = state.tasklist.map((task) {
  //     // ignore: unrelated_type_equality_checks
  //     return task.id == id
  //         ? task.copyWith(isCompleted: !task.isCompleted)
  //         : task;
  //   }).toList();
  //   emit(UpdateTask(newList));
  // }
}
