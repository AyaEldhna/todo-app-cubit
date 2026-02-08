import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usma_elgendy_bloc/controller/bloc/task_bloc.dart';
import 'package:usma_elgendy_bloc/controller/bloc/task_event.dart';
import 'package:usma_elgendy_bloc/models/task_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          create: (context) => TaskBloc(),
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    TextField(
                      controller: widget.controller,
                      decoration: const InputDecoration(hintText: 'Enter Task'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.controller.text.isEmpty) return;
                        context.read<TaskBloc>().add(
                          AddTaskEvent(TaskModel(
                            id: Uuid().v4(),
                            title: widget.controller.text,
                            isCompleted: false,
                          )),
                        );
                        widget.controller.clear();
                      },
                      child: const Text('Add Task'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.tasklist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(state.tasklist[index].title),
                            leading: Checkbox(
                              value: state.tasklist[index].isCompleted,
                              onChanged: (_) {
                                context.read<TaskBloc>().add(
                                  ToggleTaskEvent(state.tasklist[index].id),
                                );
                              },
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<TaskBloc>().add(
                                  RemoveTaskEvent(state.tasklist[index].id),
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
