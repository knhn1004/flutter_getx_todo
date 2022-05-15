import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/core/utils/extensions.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeController.selectedTask.value!;
    var color = HexColor.fromHex(task.color);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    homeController.selectTask(null);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
            child: Row(
              children: [
                Icon(
                  IconData(
                    task.icon,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: color,
                ),
                SizedBox(width: 3.0.wp),
                Text(task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
