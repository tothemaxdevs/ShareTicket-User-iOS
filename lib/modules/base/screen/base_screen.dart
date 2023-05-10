import 'package:flutter/material.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';

class BaseArgument {
  final String title;

  BaseArgument(this.title);
}

class BaseScreen extends StatefulWidget {
  final BaseArgument? argument;

  const BaseScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/base';
  static const String title = 'base';

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = BaseScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: appBar(
        context: context,
        backButton: true,
        title: BaseScreen.title,
      ),
      body: Center(
        child: Text('$title'),
      ),
    );
  }
}
