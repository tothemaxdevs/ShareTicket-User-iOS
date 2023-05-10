import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/notification/component/notification_tile.dart';
import 'package:shareticket/modules/notification/screen/notification_detail_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';

class NotificationArgument {
  final String title;

  NotificationArgument(this.title);
}

class NotificationScreen extends StatefulWidget {
  final NotificationArgument? argument;

  const NotificationScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/notification';
  static const String title = 'Notification';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = NotificationScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.screenBackground,
        appBar: appBar(
            context: context, title: LocaleKeys.notification, backButton: true),
        body: Column(
          children: [
            Center(
              child: IllustrationWidget(
                illustration: 'ic_illustration_empty.svg',
                showButton: false,
                title: 'Kosong',
                description: 'Tidak ada notifikasi masuk',
              ),
            )
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.all(Dimens.size16),
            //     itemCount: 10,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container(
            //         padding: EdgeInsets.only(bottom: Dimens.size8),
            //         child: NotificationTile(
            //             title: 'Important information',
            //             description:
            //                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor elit accumsan auctor morbi. ',
            //             date: '02 Oktober 2021',
            //             onTap: () {
            //               Navigator.pushNamed(
            //                   context, NotificationDetailScreen.path);
            //             }),
            //       );

            //       return Loading();
            //     },
            //   ),
            // )
          ],
        ));
  }

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
}
