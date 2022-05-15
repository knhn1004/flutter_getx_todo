import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:flutter_getx_todo/app/modules/home/widgets/add_card.dart';
import 'package:flutter_getx_todo/app/modules/home/widgets/task_card.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_getx_todo/app/core/utils/extensions.dart';

import '../../data/models/task.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: DragTarget(
          builder: (_, __, ___) => Obx(() => FloatingActionButton(
                onPressed: () {},
                backgroundColor:
                    controller.deleting.value ? Colors.red : Colors.blue[900],
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add),
              )),
          onAccept: (task) {
            if (task is Task) {
              controller.deleteTask(task);
            }
            EasyLoading.showSuccess('Task Deleted');
          },
        ),
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
                  ...controller.tasks.map((task) => LongPressDraggable(
                        data: task,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (_, __) =>
                            controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        feedback:
                            Opacity(opacity: 0.8, child: TaskCard(task: task)),
                        child: TaskCard(task: task),
                      )),
                  AddCard(),
                ],
              ))
        ])));
  }
}
