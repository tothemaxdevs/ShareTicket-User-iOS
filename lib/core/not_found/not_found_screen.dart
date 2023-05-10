import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class NotFoundArgument {
  final String title;

  NotFoundArgument(this.title);
}

class NotFoundScreen extends StatefulWidget {
  final NotFoundArgument? argument;

  const NotFoundScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/notfound';
  static const String title = 'Not Found';

  @override
  _NotFoundScreenState createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = NotFoundScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IllustrationWidget(
        type: IllustrationWidgetType.notFound,
      ),
    );
  }
}
