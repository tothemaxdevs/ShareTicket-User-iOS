import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefreshWidget extends StatefulWidget {
  final LoadStatus? indicatorMode;
  final RefreshController controller;
  final Function()? onLoading;
  final Function()? onRefresh;
  final Widget child;
  final bool? enablePullDown;
  final bool? enablePullUp;
  const PullRefreshWidget({
    Key? key,
    this.indicatorMode,
    required this.controller,
    this.onLoading,
    this.onRefresh,
    this.enablePullDown,
    this.enablePullUp,
    required this.child,
  }) : super(key: key);

  @override
  _PullRefreshWidgetState createState() => _PullRefreshWidgetState();
}

class _PullRefreshWidgetState extends State<PullRefreshWidget> {
  String? title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: widget.enablePullDown ?? true,
        enablePullUp: widget.enablePullUp ?? true,
        header: WaterDropHeader(
          waterDropColor: Pallete.primary,
          refresh: loading(foldingCube: true),
          complete: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
              divideW10,
              TextWidget(
                'Berhasil memperbaharui!',
                size: TextWidgetSize.h7,
                weight: FontWeight.w600,
                textColor: Colors.grey,
              )
            ],
          ),
          // idleIcon: const SvgUI(
          //   'ic_logo_2.svg',
          //   width: 15,
          //   height: 15,
          // ),
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (widget.indicatorMode == LoadStatus.idle) {
              body = const Text("pull up load");
            } else if (widget.indicatorMode == LoadStatus.loading) {
              body = loading();
            } else if (widget.indicatorMode == LoadStatus.failed) {
              body = const Text("Load Failed! Click retry!");
            } else if (widget.indicatorMode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = TextWidget(
                'Lihat-lihat lagi ke atas yuk!',
                size: TextWidgetSize.h7,
                weight: FontWeight.w600,
                textColor: Colors.grey,
              );
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        child: widget.child);
  }
}
