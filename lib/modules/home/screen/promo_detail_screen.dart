import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class PromoDetailArgument {
  final String title;

  PromoDetailArgument(this.title);
}

class PromoDetailScreen extends StatefulWidget {
  final PromoDetailArgument? argument;

  const PromoDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/Promo';
  static const String title = 'Promo detail';

  @override
  _PromoDetailScreenState createState() => _PromoDetailScreenState();
}

class _PromoDetailScreenState extends State<PromoDetailScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = PromoDetailScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            appBar(context: context, title: 'Promo detail', backButton: true),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  NetworkImagePlaceHolder(
                    imageUrl:
                        'https://www.tiket.com/homepage-v4/_next/image?url=https%3A%2F%2Fs-light.tiket.photos%2Ft%2F01E25EBZS3W0FY9GTG6C42E1SE%2Fdiscovery-desktop%2Fpromo%2F2022%2F08%2F22%2Fb7f77254-aa17-4015-8f84-a425401dfab8-1661129273293-3634704c4cc912a6649555cde4353989.png&w=2048&q=75',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size16, vertical: Dimens.size8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          'Important information',
                          weight: FontWeight.bold,
                          size: TextWidgetSize.h5,
                          textColor: Pallete.primary,
                        ),
                        divide8,
                        TextWidget(
                          'BIGSALE1111',
                          weight: FontWeight.bold,
                          size: TextWidgetSize.h6,
                          textColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  divideThick(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size16, vertical: Dimens.size8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'Valid until',
                          size: TextWidgetSize.h7,
                          weight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        TextWidget(
                          '14 August 2022',
                          size: TextWidgetSize.h7,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  divideThick(
                    height: 10.0,
                  ),
                  divide8,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size16, vertical: Dimens.size8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          'Description',
                          size: TextWidgetSize.h6,
                          weight: FontWeight.w600,
                          textColor: Pallete.primary,
                        ),
                        divide10,
                        TextWidget(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed turpis nec morbi at elit nibh elementum auctor sollicitudin. Semper sem adipiscing et pulvinar feugiat at aliquam venenatis fusce. Viverra posuere ornare elementum ipsum morbi cursus urna scelerisque. Sit pellentesque massa molestie phasellus. Habitant elit venenatis purus sapien, aliquam aliquet. Viverra hendrerit vehicula magna aliquet. Tortor mi tincidunt sit tortor suspendisse.',
                          textColor: Colors.grey,
                          size: TextWidgetSize.h7,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            divideThick(),
            Container(
              padding: const EdgeInsets.all(Dimens.size16),
              child: RoundedButton(
                press: copyCode,
                width: double.infinity,
                text: 'Copy code',
              ),
            )
          ],
        ));
  }

  // void showAll(BuildContext context, String title) {
  //   bottomSheet(
  //       context,
  //       title,
  //       Expanded(
  //           child: Column(
  //         children: [
  //           Center(
  //               child: IllustrationWidget(
  //             type: IllustrationWidgetType.notFound,
  //           )),
  //         ],
  //       )),
  //       height: 600);
  // }

  Widget Loading() {
    return ListTile(
      leading: const Blink(
        height: 36,
        width: 36,
        isCircle: true,
      ),
      title: Container(
        padding: const EdgeInsets.only(top: Dimens.size4, bottom: Dimens.size4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Blink(height: 16, width: 100),
            divide4,
            const Blink(height: 10, width: double.infinity),
            divide2,
            const Blink(height: 10, width: double.infinity),
            divide2,
            const Blink(height: 10, width: 70),
          ],
        ),
      ),
    );
  }

  copyCode() {
    Clipboard.setData(const ClipboardData(text: 'Hello copied')).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Code copied!')));
    });
  }
}
