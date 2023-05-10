import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/widget/images/circle_avatar.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ProfileDetailTile extends StatelessWidget {
  bool? profileMode;
  String? imgUrl;
  String? title;
  String? subtitle;
  Function()? onTap;
  ProfileDetailTile(
      {Key? key,
      this.profileMode = false,
      this.imgUrl,
      this.subtitle,
      this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            profileMode == true
                ? CircleAvatars(
                    imageUrl: '$imgUrl',
                    size: 60,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        '$title',
                        fontSize: Dimens.size12,
                        weight: FontWeight.bold,
                      ),
                      TextWidget(
                        '$subtitle',
                        fontSize: Dimens.size14,
                        textColor: (LocaleKeys.core_not_set).tr() == subtitle
                            ? Colors.red
                            : Pallete.textPrimary,
                      )
                    ],
                  ),
            TextButton(
                onPressed: onTap,
                child: TextWidget(
                  LocaleKeys.core_change,
                  textColor: Pallete.primary,
                  size: TextWidgetSize.h6,
                  weight: FontWeight.w600,
                ))
          ],
        ),
        Divider()
      ],
    );
  }
}
