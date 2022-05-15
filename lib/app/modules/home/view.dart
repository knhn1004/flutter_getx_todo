import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Page')));
  }
}
