import 'package:flutter/material.dart';
import 'package:shareticket/config/size/size.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key? key,
    this.title,
    this.color = '#ffffff',
    this.description,
    this.imageFileName,
  }) : super(key: key);

  final String? title, description, imageFileName, color;

  @override
  Widget build(BuildContext context) {
    initSizeConfig(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        divide32,
        SvgUI(
          '$imageFileName',
          width: 300,
          height: 300,
        ),
        divide28,
        Text(
          title ?? '',
          style: const TextStyle(
              fontSize: Dimens.size24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        divide16,
        Container(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Text(
            description ?? '',
            style: const TextStyle(
              fontSize: Dimens.size16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        divide10,
      ],
    );
  }
}
