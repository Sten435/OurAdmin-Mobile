import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorBar(context, String text, {Function? callback}) {
  Flushbar(
    messageText: Text(
      text.toString(),
      style: const TextStyle(
        fontSize: 18.0,
        color: Colors.red,
      ),
    ),
    icon: const Icon(
      Icons.info,
      size: 28.0,
      color: Colors.red,
    ),
    duration: const Duration(seconds: 5),
    onStatusChanged: (status) => {
      if (status == FlushbarStatus.DISMISSED && callback != null) callback()
    },
    showProgressIndicator: true,
    backgroundColor: Colors.black,
    leftBarIndicatorColor: Colors.red,
  ).show(context);
}

void showWarningBar(context, String text) {
  Flushbar(
    message: text,
    icon: const Icon(
      Icons.info,
      size: 28.0,
      color: Colors.orange,
    ),
    duration: const Duration(seconds: 3),
    showProgressIndicator: true,
    backgroundColor: Colors.black,
    leftBarIndicatorColor: Colors.orange,
  ).show(context);
}
