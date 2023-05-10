import 'package:flutter/material.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';

class RegisterSuccessArgument {
  final String title;

  RegisterSuccessArgument(this.title);
}

class RegisterSuccessScreen extends StatefulWidget {
  final RegisterSuccessArgument? argument;

  const RegisterSuccessScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/register/success';
  static const String title = 'Register Success';

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = RegisterSuccessScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IllustrationWidget(
      type: IllustrationWidgetType.success,
    ));
  }
}
