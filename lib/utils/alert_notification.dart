import 'package:flutter/material.dart';

void showMyDialog(
    {required BuildContext context,
    String title = 'Thông báo',
    String content = "",
    required VoidCallback onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,
            textAlign: TextAlign.center,
            style:
                const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
