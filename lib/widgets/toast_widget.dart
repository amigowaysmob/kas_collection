import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';


class ToastWidget extends StatelessWidget {
  final String? message;
  final Color? color;

  ToastWidget({this.message, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    // Ensure the toast is shown after the build method completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (message != null && message!.isNotEmpty) {
        Fluttertoast.showToast(
          msg: message!.replaceAll("Exception:", ""),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: color,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });

    // Return an empty widget
    return SizedBox.shrink();
  }
}
