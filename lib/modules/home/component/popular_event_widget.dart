import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class PopularEventWidget extends StatelessWidget {
  final String thumbnail, title, date, eventType, price;
  final Function()? onTap;
  PopularEventWidget({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.date,
    required this.eventType,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: Dimens.size10),
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
          child: Container(
            padding: const EdgeInsets.all(Dimens.size6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Dimens.size10)),
                  child: NetworkImagePlaceHolder(
                      fit: BoxFit.cover,
                      width: 300,
                      height: 170,
                      imageUrl: thumbnail),
                ),
                divide2,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.size4, horizontal: Dimens.size10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title,
                        ellipsed: true,
                        weight: FontWeight.bold,
                        size: TextWidgetSize.h6,
                        textColor: Pallete.primary,
                        maxLines: 1,
                      ),
                      TextWidget(
                        date,
                        ellipsed: true,
                        weight: FontWeight.w500,
                        size: TextWidgetSize.h8,
                        textColor: Colors.grey,
                      ),
                      divide4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            eventType,
                            size: TextWidgetSize.h7,
                            weight: FontWeight.w500,
                            textColor: Colors.green,
                            ellipsed: true,
                            maxLines: 1,
                          ),
                          // TextWidget(
                          //   rupiahFormatter(value: price),
                          //   textColor: Colors.red,
                          //   size: TextWidgetSize.h6,
                          //   weight: FontWeight.bold,
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
