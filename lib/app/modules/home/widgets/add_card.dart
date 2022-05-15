import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/app/modules/home/controller.dart';
import 'package:flutter_getx_todo/app/widgets/icons.dart';
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
          onTap: () {},
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
