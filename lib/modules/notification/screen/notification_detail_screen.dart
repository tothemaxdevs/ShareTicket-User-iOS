import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/notification/component/notification_tile.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class NotificationDetailArgument {
  final String title;

  NotificationDetailArgument(this.title);
}

class NotificationDetailScreen extends StatefulWidget {
  final NotificationDetailArgument? argument;

  const NotificationDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/notification/detail';
  static const String title = 'Notification';

  @override
  _NotificationDetailScreenState createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = NotificationDetailScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            context: context, title: LocaleKeys.notification, backButton: true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SvgUI('ic_notification_banner.svg'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      'Important information',
                      weight: FontWeight.bold,
                      size: TextWidgetSize.h6,
                      textColor: Pallete.primary,
                    ),
                    divide8,
                    TextWidget(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed turpis nec morbi at elit nibh elementum auctor sollicitudin. Semper sem adipiscing et pulvinar feugiat at aliquam venenatis fusce. Viverra posuere ornare elementum ipsum morbi cursus urna scelerisque. Sit pellentesque massa molestie phasellus. Habitant elit venenatis purus sapien, aliquam aliquet. Viverra hendrerit vehicula magna aliquet. Tortor mi tincidunt sit tortor suspendisse.',
                      textColor: Colors.grey,
                      size: TextWidgetSize.h7,
                    ),
                    divide4,
                    TextWidget(
                      '02 Oktober 2021',
                      size: TextWidgetSize.h8,
                      textColor: Colors.red,
                      weight: FontWeight.w600,
                    )
                  ],
                ),
              ),
            ],
          ),
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

}
