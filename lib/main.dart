import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/data/services/storage/services.dart';
import 'package:flutter_getx_todo/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'GetX TODO',
      home: HomePage(),
    );
  }
}
