import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class DoubleTextButton extends StatelessWidget {
  Function()? onPressed;
  String normalText;
  String boldText;

  DoubleTextButton(
      {Key? key,
      this.onPressed,
      required this.normalText,
      required this.boldText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          normalText,
          size: TextWidgetSize.h6,
          fontSize: Dimens.size14,
          weight: FontWeight.w500,
        ),
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.size8, horizontal: Dimens.size2),
            child: TextWidget(boldText,
                fontSize: Dimens.size14,
                weight: FontWeight.bold,
                textColor: Pallete.primary),
          ),
        ),
      ],
    );
  }
}
