import 'package:flutter/widgets.dart';
import 'package:flutter_getx_todo/app/data/models/task.dart';
import 'package:flutter_getx_todo/app/data/services/storage/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;

  final selectedTask = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void selectTask(Task? selected) {
    selectedTask.value = selected;
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containsTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTask;
    tasks.refresh();
    return true;
  }

  bool containsTodo(List todos, String title) {
    return todos.any((t) => t['title'] == title);
  }
}
