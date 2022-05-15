import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/app/core/utils/extensions.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:get/get.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: homeController.formKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(3.0.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: handleClose,
                ),
                TextButton(
                    onPressed: handleDone,
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    child: Text('Done',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                        )))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: Text('New Task',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: TextFormField(
              controller: homeController.editController,
              decoration: InputDecoration(
                hintText: 'Enter your task',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your todo item';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0.wp,
              left: 5.0.wp,
              right: 5.0.wp,
              bottom: 2.0.wp,
            ),
            child: Text('Add to',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                )),
          ),
          ...homeController.tasks.map((task) => Obx(
                () => InkWell(
                  onTap: () => homeController.selectTask(task),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp, horizontal: 5.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              IconData(
                                task.icon,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: HexColor.fromHex(task.color),
                            ),
                            SizedBox(width: 3.0.wp),
                            Text(task.title,
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        if (homeController.selectedTask.value == task)
                          const Icon(Icons.check, color: Colors.blue)
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    ));
  }

  void handleClose() {
    Get.back();
    homeController.editController.clear();
    homeController.selectTask(null);
  }

  void handleDone() {
    if (!homeController.formKey.currentState!.validate()) {
      EasyLoading.showError('Please fill out the fields');
      return;
    }
    if (homeController.selectedTask.value == null) {
      EasyLoading.showError('Please select task type');
      return;
    }
    if (!homeController.updateTask(
      homeController.selectedTask.value!,
      homeController.editController.text,
    )) {
      EasyLoading.showError('Todo Item already exists');
      return;
    }
    EasyLoading.showSuccess('Task Updated');
    Get.back();
    homeController.editController.clear();
    homeController.selectTask(null);
  }
}
