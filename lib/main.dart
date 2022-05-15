import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/modules/home/view.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'GetX TODO',
      home: HomePage(),
    );
  }
}
