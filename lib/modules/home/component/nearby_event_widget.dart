import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class NearByEventWidget extends StatelessWidget {
  final String thumbnail, title, date, price, eventType;
  final Color? backgroundColor;
  final Function()? onTap;
  NearByEventWidget({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.date,
    required this.price,
    required this.eventType,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dimens.size10),
      width: 150,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(Dimens.size6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: NetworkImagePlaceHolder(
                      imageUrl: thumbnail,
                      width: 150,
                      height: 180,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimens.size10))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title,
                        weight: FontWeight.bold,
                        size: TextWidgetSize.h7,
                        textColor: Pallete.primary,
                        maxLines: 1,
                        ellipsed: true,
                      ),
                      divide4,
                      TextWidget(
                        date,
                        ellipsed: true,
                        weight: FontWeight.w500,
                        size: TextWidgetSize.h8,
                        textColor: Colors.grey,
                      ),
                      divide2,
                      TextWidget(
                        eventType,
                        textColor: Colors.green,
                        size: TextWidgetSize.h7,
                        weight: FontWeight.w500,
                        maxLines: 1,
                        ellipsed: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   right: 4,
            //   top: 4,
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            //     decoration: const BoxDecoration(
            //         borderRadius: const BorderRadius.all(
            //             Radius.circular(Dimens.size128)),
            //         color: Colors.green),
            //     child: TextWidget(
            //       eventType,
            //       size: TextWidgetSize.h8,
            //       weight: FontWeight.w600,
            //       textColor: Colors.white,
            //     ),
            //   ),
            // )
            //   ],
            // )
          ),
        ),
      ),
    );
  }
}
