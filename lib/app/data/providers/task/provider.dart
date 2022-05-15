import 'dart:convert';

import 'package:flutter_getx_todo/app/core/utils/keys.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_todo/app/data/services/storage/services.dart';

import '../../models/task.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach((task) {
      tasks.add(Task.fromJson(task));
    });
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
