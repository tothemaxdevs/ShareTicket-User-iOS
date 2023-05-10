import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final IconData? icon;
  const CustomButton({
    Key? key,
    this.onTap,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.size10)),
        border: Border.all(color: Pallete.border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.size10)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.size10, horizontal: Dimens.size6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  title,
                  size: TextWidgetSize.h6,
                  weight: FontWeight.w600,
                ),
                divideW8,
                Icon(
                  icon,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
