import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showSuccessBar(context, String text, {Function? callback}) {
  Flushbar(
    messageText: Text(
      text.toString(),
      style: const TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
    ),
    icon: const Icon(
      Icons.info,
      size: 28.0,
      color: Colors.greenAccent,
    ),
    duration: const Duration(seconds: 5),
    onStatusChanged: (status) => {if (status == FlushbarStatus.DISMISSED && callback != null) callback()},
    showProgressIndicator: true,
    backgroundColor: Colors.black,
    leftBarIndicatorColor: Colors.greenAccent,
  ).show(context);
}
