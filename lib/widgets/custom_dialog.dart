import 'dart:io';

import 'package:dicoding_news_app/common/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CustomDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: Navigation.back(),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Coming Soon!'),
          content: const Text('This feature will be coming soon!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: Navigation.back(),
            ),
          ],
        );
      },
    );
  }
}
