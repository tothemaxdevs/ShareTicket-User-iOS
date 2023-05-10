import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/component/custom_chip.dart';
import 'package:shareticket/widget/images/circle_avatar.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class SliderWidget extends StatelessWidget {
  String imageBackground, category, title, profileImage, profileName, date;

  SliderWidget(
      {Key? key,
      required this.imageBackground,
      required this.category,
      required this.title,
      required this.profileImage,
      required this.profileName,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.size16,
      ),
      child: Stack(children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.fill,
                child: NetworkImagePlaceHolder(
                    width: MediaQuery.of(context).size.width,
                    imageUrl: imageBackground),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(
              right: Dimens.size16,
              left: Dimens.size16,
              top: Dimens.size16,
              bottom: Dimens.size32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChipCustom(
                text: category,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title,
                    size: TextWidgetSize.h4,
                    weight: FontWeight.bold,
                    textColor: Colors.white,
                    maxLines: 2,
                    ellipsed: true,
                  ),
                  divide10,
                  Row(
                    children: [
                      CircleAvatars(
                        imageUrl: profileImage,
                      ),
                      divideW6,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            profileName,
                            size: TextWidgetSize.h6,
                            textColor: Colors.white,
                            weight: FontWeight.w500,
                          ),
                          TextWidget(
                            date,
                            size: TextWidgetSize.h8,
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
