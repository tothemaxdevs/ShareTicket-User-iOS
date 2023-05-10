import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountTile extends StatelessWidget {
  String? icon;
  String? title, subtitle;
  Color? iconColor;
  Color? textColor;
  bool? isArrow;
  bool? isTick;
  Function()? onTap;

  AccountTile(
      {Key? key,
      this.icon,
      this.title,
      this.subtitle,
      this.iconColor,
      this.textColor,
      this.isArrow = true,
      this.onTap,
      this.isTick = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(Dimens.size8)),
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgUI(
                      '$icon',
                      color: iconColor ?? Pallete.primary,
                    ),
                    divideW20,
                    TextWidget(
                      '$title',
                      textColor: textColor ?? Pallete.textPrimary,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (subtitle != null)
                      TextWidget(
                        '$subtitle',
                        textColor: textColor ?? Pallete.greyDark,
                        size: TextWidgetSize.h6,
                      ),
                    divideW10,
                    if (isArrow == true)
                      const SvgUI('ic_account_right_arrow.svg')
                  ],
                )
              ],
            ),
          ),
          if (isTick == true) divideThick(color: Colors.grey.shade50)
        ],
      ),
    );
  }
}
