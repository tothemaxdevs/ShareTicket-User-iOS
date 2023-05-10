import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class SectionTile extends StatelessWidget {
  final String title;
  final Function()? onSubTap;
  SectionTile({
    Key? key,
    required this.title,
    this.onSubTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.size16, vertical: Dimens.size4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title,
            weight: FontWeight.bold,
            textColor: Pallete.primary,
            size: TextWidgetSize.h6,
          ),
          if (onSubTap != null)
            InkWell(
              onTap: onSubTap,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.size10)),
              child: TextWidget(
                LocaleKeys.core_see_all.tr(),
                weight: FontWeight.w500,
                textColor: Pallete.primary,
                size: TextWidgetSize.h7,
              ),
            ),
        ],
      ),
    );
  }
}
