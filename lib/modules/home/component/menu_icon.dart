import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class MenuIcon extends StatelessWidget {
  String? iconUrl;
  String? svgIcon;
  String title;
  bool isSvg;
  double? iconSize;
  Function() onTap;

  MenuIcon(
      {Key? key,
      this.iconUrl,
      this.svgIcon,
      required this.title,
      required this.onTap,
      this.isSvg = false,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: Dimens.size8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSvg
                ? SvgUI(
                    svgIcon,
                    width: iconSize ?? 57,
                    height: iconSize ?? 57,
                  )
                : NetworkImagePlaceHolder(
                    height: iconSize ?? 57,
                    width: iconSize ?? 57,
                    isRounded: true,
                    imageUrl: iconUrl,
                  ),
            divide4,
            TextWidget(
              title,
              textAlign: TextAlign.center,
              size: TextWidgetSize.h6,
              weight: FontWeight.w400,
              ellipsed: true,
            )
          ],
        ),
      ),
    );
  }
}
