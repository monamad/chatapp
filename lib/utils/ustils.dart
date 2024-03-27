import 'package:flutter/material.dart';

class MyUtils {
  static void showmassage(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }
}
