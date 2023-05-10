import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class NotificationTile extends StatelessWidget {
  String title, description, date;
  Function()? onTap;
  NotificationTile(
      {Key? key,
      required this.title,
      required this.description,
      required this.date,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size10))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size10)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.size10, horizontal: Dimens.size10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (notification.title != null)
                TextWidget(
                  title,
                  size: TextWidgetSize.h7,
                  weight: FontWeight.bold,
                  textColor: Pallete.primary,
                ),
                divide4,
                // if (notification.description != null)
                TextWidget(
                  description,
                  size: TextWidgetSize.h7,
                  maxLines: 1,
                  ellipsed: true,
                ),
                divide2,
                // if (notification.createdAt != null)
                TextWidget(
                  date,
                  size: TextWidgetSize.h8,
                  textColor: Colors.red,
                  weight: FontWeight.w500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
