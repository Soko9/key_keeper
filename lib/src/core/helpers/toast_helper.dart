import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ToastHelper {
  static void snackBar({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    Get.snackbar(
      title,
      content,
      colorText: Theme.of(context).textTheme.bodyLarge?.color,
      animationDuration: const Duration(milliseconds: 750),
      duration: const Duration(seconds: 1),
      titleText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12.0),
    );
  }
}
