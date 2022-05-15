import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:flutter_getx_todo/app/modules/home/widgets/add_card.dart';
import 'package:flutter_getx_todo/app/modules/home/widgets/task_card.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_getx_todo/app/core/utils/extensions.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Text(
          'My List',
          style: TextStyle(
            fontSize: 24.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Obx(() => GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...controller.tasks.map((task) => TaskCard(task: task)),
              AddCard(),
            ],
          ))
    ])));
  }
}
