import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResponsiveText on double {
  double get sp => Get.width / 100 * (this / 3);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    return Color(int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16)}';
  }
}
