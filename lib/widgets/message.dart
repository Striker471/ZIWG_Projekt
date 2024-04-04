import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care_app/main.dart';

showInfo(String text, [Color? color, double? width]) {
  FToast fToast = FToast();
  fToast.init(navigatorKey.currentContext!);
  Widget box = Container(
    height: 80,
    alignment: Alignment.center,
    width: width ?? 300,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: color ?? Colors.red, borderRadius: BorderRadius.circular(15)),
    child: Text(text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center),
  );
  fToast.showToast(child: box, gravity: ToastGravity.BOTTOM);
}
