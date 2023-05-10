import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class EventDescWidget extends StatelessWidget {
  final String title;
  final String? description;
  final String ifnulltext;
  EventDescWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.ifnulltext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        divideThick(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size16, vertical: Dimens.size8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title,
                size: TextWidgetSize.h6,
                weight: FontWeight.w600,
                textColor: Pallete.primary,
              ),
              divide6,
              HtmlWidget(
                description ?? ifnulltext,
                textStyle: const TextStyle(
                    color: Pallete.greyDark,
                    fontSize: Dimens.size12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ],
    );
  }
}
