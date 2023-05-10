import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/component/dot_circle.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ArticleList extends StatelessWidget {
  String? userPicture;
  String? userName;
  String? title;
  String? descriptions;
  String? date;
  String? readingTime;
  String? image;
  Function()? onTap;

  ArticleList(
      {Key? key,
      this.userPicture,
      this.userName,
      this.title,
      this.date,
      this.readingTime,
      this.descriptions,
      this.image,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: Dimens.size16, vertical: Dimens.size2),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.size8),
            child: Row(
              children: [
                NetworkImagePlaceHolder(
                  width: 64,
                  height: 64,
                  isRounded: true,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  imageUrl: '$image',
                ),
                divideW10,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        '$title',
                        size: TextWidgetSize.h7,
                        maxLines: 1,
                        weight: FontWeight.w600,
                        textColor: Pallete.primary,
                        ellipsed: true,
                      ),
                      divide2,
                      TextWidget(
                        '$descriptions',
                        size: TextWidgetSize.h8,
                        maxLines: 1,
                        // weight: FontWeight.w600,
                        textColor: Colors.grey,
                        ellipsed: true,
                      ),
                      divide6,
                      Row(
                        children: [
                          TextWidget(
                            '$date',
                            size: TextWidgetSize.h8,
                            weight: FontWeight.w500,
                            textColor: Pallete.greyDark,
                          ),
                          divideW4,
                          DotCircle(
                            size: 3,
                          ),
                          divideW4,
                          TextWidget(
                            '$readingTime',
                            size: TextWidgetSize.h8,
                            weight: FontWeight.w500,
                            textColor: Pallete.greyDark,
                          ),
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
