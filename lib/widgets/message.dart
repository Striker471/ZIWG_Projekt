import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

void displayDeleteMotionToast(String text, BuildContext context) {
  MotionToast.delete(
    title: const Text(
      'Deleted',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(text),
    animationType: AnimationType.fromBottom,
    position: MotionToastPosition.bottom,
    barrierColor: Colors.black.withOpacity(0.3),
    width: 300,
    height: 80,
    dismissable: false,
  ).show(context);
}

void displayErrorMotionToast(String text, BuildContext context) {
  MotionToast.error(
    title: const Text(
      'Error',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    description: Text(text),
    animationType: AnimationType.fromBottom,
    position: MotionToastPosition.bottom,
    barrierColor: Colors.black.withOpacity(0.3),
    width: 300,
    height: 80,
    dismissable: false,
  ).show(context);
}

void displaySuccessMotionToast(String text, BuildContext context) {
  MotionToast toast = MotionToast(
    primaryColor: Colors.red,
    description: Text(
      text,
      style: const TextStyle(fontSize: 12),
    ),
    animationType: AnimationType.fromBottom,
    position: MotionToastPosition.bottom,
    barrierColor: Colors.black.withOpacity(0.3),
    width: 300,
    height: 80,
    dismissable: false,
  );
  toast.show(context);
}
