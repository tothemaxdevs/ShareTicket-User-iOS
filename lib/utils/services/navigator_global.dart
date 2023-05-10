import 'package:flutter/material.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import './navigator_key.dart';

class GlobalNavigator {
  static showAlertDialog(String text, {Function()? onClick}) {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: DialogBox(
            title: 'Sesi berakhir!',
            descriptions:
                'Sesi akun anda telah berakhir, silahkan login kembali.',
            onOkTap: () {
              Navigator.pop(context, true);
              onClick!();
            },
            onOkText: 'Masuk',
          ),
        );

        AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                onClick!();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static pop() {
    navigatorKey.currentState?.pop();
  }

  static popUntil(String routeName) {
    navigatorKey.currentState?.popUntil((route) {
      return route.settings.name == routeName;
    });
  }
}
