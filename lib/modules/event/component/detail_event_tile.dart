import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class DetailEventTile extends StatelessWidget {
  final String label, icon;
  DetailEventTile({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgUI(
          icon,
          width: 22,
          height: 22,
        ),
        divideW6,
        Flexible(
          child: TextWidget(
            label,
            size: TextWidgetSize.h8,
            weight: FontWeight.w500,
            textColor: Pallete.greyDark,
            ellipsed: true,
          ),
        ),
      ],
    );
  }
}
