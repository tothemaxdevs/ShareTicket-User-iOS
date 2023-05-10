import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget body;
  CustomScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.screenBackground,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
