import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/model/content_result/content.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ArticleByIdArgument {
  final Content content;

  ArticleByIdArgument({required this.content});
}

class ArticleByIdScreen extends StatefulWidget {
  final ArticleByIdArgument? argument;

  const ArticleByIdScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  static const String path = '/news/details';
  static const String title = '';

  @override
  _ArticleByIdScreenState createState() => _ArticleByIdScreenState();
}

class _ArticleByIdScreenState extends State<ArticleByIdScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScaffold(
            appBar: appBar(
              context: context,
              title: ArticleByIdScreen.title,
              backButton: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.size16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      widget.argument!.content.title,
                      textColor: Pallete.primary,
                      weight: FontWeight.bold,
                      size: TextWidgetSize.h3,
                    ),
                    divide16,
                    NetworkImagePlaceHolder(
                        height: 180,
                        width: double.infinity,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.size16)),
                        imageUrl: widget.argument!.content.thumbnail),

                    divide6,
                    TextWidget(
                      widget.argument!.content.createdAt,
                      size: TextWidgetSize.h7,
                    ),
                    divide10,
                    HtmlWidget(widget.argument!.content.description!)
                    // TextWidget(
                    //   widget.argument!.content.descriptionText,
                    //   textColor: Pallete.primary,
                    //   size: TextWidgetSize.h7,
                    // )
                  ],
                ),
              ),
            )));
  }
}
