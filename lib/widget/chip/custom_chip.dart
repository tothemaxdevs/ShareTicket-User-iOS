import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class CustomChip extends StatelessWidget {
  const CustomChip(
      {Key? key,
      this.padding,
      this.radius,
      this.backgroundColor,
      this.borderColor,
      this.label,
      this.labelColor,
      this.onTap})
      : super(key: key);

  final double? radius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor, borderColor, labelColor;
  final String? label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? Dimens.size8),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? Dimens.size8),
            border: Border.all(
              color: borderColor ?? Colors.grey.shade200,
            ),
            color: backgroundColor ?? Colors.white),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(Dimens.size8),
          child: TextWidget(
            '$label',
            textAlign: TextAlign.center,
            size: TextWidgetSize.h7,
            weight: FontWeight.w500,
            textColor: labelColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
