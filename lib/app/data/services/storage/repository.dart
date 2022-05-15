import 'package:flutter_getx_todo/app/data/models/task.dart';
import 'package:flutter_getx_todo/app/data/providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() {
    return taskProvider.readTasks();
  }

  void writeTasks(List<Task> tasks) {
    taskProvider.writeTasks(tasks);
  }
}
