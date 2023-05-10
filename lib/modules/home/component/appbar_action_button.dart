import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

class AppBarActionButton extends StatelessWidget {
  final String icon;
  final Function()? onTap;
  final double? containerSize, iconSize, radius;
  AppBarActionButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.containerSize,
    this.iconSize,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(Dimens.size10)),
      onTap: onTap,
      child: Container(
          width: containerSize ?? 30,
          height: containerSize ?? 30,
          padding: const EdgeInsets.all(Dimens.size4),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(radius ?? Dimens.size10)),
              border: Border.all(color: Colors.grey.shade300)),
          child: SvgUI(
            icon,
            width: iconSize ?? 18,
            height: iconSize ?? 18,
            color: Pallete.primary,
          )),
    );
  }
}
