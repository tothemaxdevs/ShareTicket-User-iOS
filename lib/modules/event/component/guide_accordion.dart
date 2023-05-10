import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'dart:math' as math;

class GuideAccordion extends StatelessWidget {
  final String title;
  final String guide;
  const GuideAccordion({
    Key? key,
    required this.title,
    required this.guide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionWidget(
        initiallyExpanded: false,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
              onTap: () => toogleFunction(animated: true),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(title,
                            style: const TextStyle(
                              fontSize: Dimens.size14,
                              fontWeight: FontWeight.w600,
                            ))),
                    Transform.rotate(
                      angle: math.pi * animationValue / 2,
                      alignment: Alignment.center,
                      child:
                          const SvgUI('ic_account_right_arrow.svg', width: 25),
                    )
                  ],
                ),
              ));
        },
        content: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Dimens.size2),
          child: HtmlWidget(guide),
        ));
  }
}
