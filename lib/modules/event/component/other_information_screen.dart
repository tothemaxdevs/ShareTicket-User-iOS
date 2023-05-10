import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/event/screen/stage_detail_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class OtherInformationWidget extends StatelessWidget {
  int? currentIndex;
  List<String>? imageList;
  Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  OtherInformationWidget(
      {Key? key, this.currentIndex, this.imageList, this.onPageChanged})
      : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    // 'Stage',
                    LocaleKeys.event_other_information.tr(),
                    size: TextWidgetSize.h6,
                    weight: FontWeight.w600,
                    textColor: Pallete.primary,
                  ),
                  Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Dimens.size16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imageList!.map(
                                  (image) {
                                    int index = imageList!.indexOf(image);
                                    return Container(
                                      width: 7.0,
                                      height: 7.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: currentIndex == index
                                            ? Pallete.primary
                                            : Colors.grey.shade300,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
              divide6,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, StageDetailScreen.path,
                      arguments: StageDetailArgument(
                          stageList: imageList!, initialIndex: currentIndex!));
                },
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    onPageChanged: onPageChanged,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    // autoPlayInterval: const Duration(seconds: 5),
                    // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 1,
                    aspectRatio: 2.2 / 1.4,
                    initialPage: 0,
                  ),
                  itemCount: imageList!.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    if (imageList!.isNotEmpty) {
                      var stage = imageList![itemIndex];
                      return NetworkImagePlaceHolder(
                        isRounded: true,
                        borderRadius: BorderRadius.circular(10),
                        imageUrl: stage,
                        width: double.infinity,
                        // height: 171,
                        fit: BoxFit.cover,
                      );
                    }
                    return Container();
                  },
                ),
              ),
              // NetworkImagePlaceHolder(
              //     borderRadius: const BorderRadius.all(
              //         Radius.circular(Dimens.size10)),
              //     imageUrl:
              //         'https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/rsfit621414gsm/events/2022/05/25/5f36edce-f024-449d-830a-93d286c20283-1653445269493-6d8fcfc4aeff86f9a40b8d069073e808.jpg')
            ],
          ),
        ),
      ],
    );
  }
}
