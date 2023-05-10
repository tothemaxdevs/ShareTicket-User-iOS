import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';

enum TextWidgetSize { h1, h2, h3, h4, h5, h6, h7, h8, h9 }

class TextWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool? ellipsed;
  final bool? isCurrency;
  TextAlign? textAlign;
  TextDecoration? decoration;
  double? fontSize;
  int? maxLines;
  final FontWeight? weight;
  final TextWidgetSize? size;
  TextWidget(this.text,
      {Key? key,
      this.textColor,
      this.ellipsed = false,
      this.size,
      this.weight,
      this.decoration,
      this.isCurrency = false,
      this.fontSize,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case TextWidgetSize.h9:
        fontSize = Dimens.size8;
        break;
      case TextWidgetSize.h8:
        fontSize = Dimens.size10;
        break;
      case TextWidgetSize.h7:
        fontSize = Dimens.size12;
        break;
      case TextWidgetSize.h6:
        fontSize = Dimens.size14;
        break;
      case TextWidgetSize.h5:
        fontSize = Dimens.size16;
        break;
      case TextWidgetSize.h4:
        fontSize = Dimens.size18;
        break;
      case TextWidgetSize.h3:
        fontSize = Dimens.size20;
        break;
      case TextWidgetSize.h2:
        fontSize = Dimens.size24;
        break;
      case TextWidgetSize.h1:
        fontSize = Dimens.size32;
        break;
      default:
    }
    return Text(
      isCurrency == true ? rupiahFormatter(value: '$text') : '$text',
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          decoration: decoration,
          color: textColor ?? Pallete.textPrimary,
          overflow:
              ellipsed == true ? TextOverflow.ellipsis : TextOverflow.visible,
          fontSize: fontSize ?? Dimens.size16,
          fontWeight: weight),
    ).tr();
  }
}
