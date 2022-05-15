import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/app/data/services/storage/services.dart';
import 'package:flutter_getx_todo/app/modules/home/binding.dart';
import 'package:flutter_getx_todo/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX TODO',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
