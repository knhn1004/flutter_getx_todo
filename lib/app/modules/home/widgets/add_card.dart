import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/app/data/models/task.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:flutter_getx_todo/app/widgets/icons.dart';
import 'package:flutter_getx_todo/app/core/values/colors.dart';
import 'package:flutter_getx_todo/app/core/utils/extensions.dart';
import 'package:get/get.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
          onTap: () async {
            await Get.defaultDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
                radius: 5,
                title: 'Task Type',
                content:
                    DialogForm(homeController: homeController, icons: icons));
            homeController.editController.clear();
            homeController.changeChipIndex(0);
          },
          child: DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [8, 4],
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 10.0.wp,
                  color: Colors.grey,
                ),
              ))),
    );
  }
}

class DialogForm extends StatelessWidget {
  const DialogForm({
    Key? key,
    required this.homeController,
    required this.icons,
  }) : super(key: key);

  final HomeController homeController;
  final List<Icon> icons;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: homeController.formKey,
        child: Column(
          children: [
            InputArea(homeController: homeController),
            ChipsArea(icons: icons, homeController: homeController),
            SubmitButton(homeController: homeController, icons: icons)
          ],
        ));
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.homeController,
    required this.icons,
  }) : super(key: key);

  final HomeController homeController;
  final List<Icon> icons;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size(150, 40),
      ),
      onPressed: () {
        if (homeController.formKey.currentState!.validate()) {
          var currentIcon = icons[homeController.chipIndex.value];
          int icon = currentIcon.icon!.codePoint;
          String color = HexColor.toHex(currentIcon.color!);
          Task task = Task(
            title: homeController.editController.text,
            icon: icon,
            color: color,
          );
          Get.back();
          homeController.addTask(task)
              ? EasyLoading.showSuccess('Create success')
              : EasyLoading.showError('Create failed');
        }
      },
      child: const Text('Confirm'),
    );
  }
}

class ChipsArea extends StatelessWidget {
  const ChipsArea({
    Key? key,
    required this.icons,
    required this.homeController,
  }) : super(key: key);

  final List<Icon> icons;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 5.0.wp),
      child: Wrap(
        spacing: 2.0.wp,
        runSpacing: 2.0.wp,
        children: icons
            .map((icon) => Obx(() {
                  final index = icons.indexOf(icon);
                  return ChoiceChip(
                    label: icon,
                    selected: homeController.chipIndex.value == index,
                    onSelected: (bool selected) {
                      homeController.chipIndex.value = selected ? index : 0;
                    },
                    selectedColor: Colors.grey[200],
                    backgroundColor: Colors.white,
                    pressElevation: 0,
                  );
                }))
            .toList(),
      ),
    );
  }
}

class InputArea extends StatelessWidget {
  const InputArea({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
      child: TextFormField(
        controller: homeController.editController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
