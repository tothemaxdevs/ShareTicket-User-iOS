import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/component/article_list.dart';
import 'package:shareticket/modules/home/component/article_list_loading.dart';
import 'package:shareticket/modules/home/model/filter_data.dart';
import 'package:shareticket/modules/home/screen/article_by_id_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/chip/custom_chip.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ArticleByCategoryArgument {
  final String title;

  ArticleByCategoryArgument(this.title);
}

class ArticleByCategoryScreen extends StatefulWidget {
  final ArticleByCategoryArgument? argument;

  const ArticleByCategoryScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/articlebycategory';
  static const String title = 'Article By Category';

  @override
  _ArticleByCategoryScreenState createState() =>
      _ArticleByCategoryScreenState();
}

class _ArticleByCategoryScreenState extends State<ArticleByCategoryScreen> {
  String? title;
  List<FilterData> filter = [
    FilterData(name: 'Natural', isSelected: false),
    FilterData(name: 'Sport', isSelected: false),
    FilterData(name: 'Food', isSelected: false),
    FilterData(name: 'Champion', isSelected: false),
    FilterData(name: 'GP', isSelected: false),
    FilterData(name: 'Phone', isSelected: false),
    FilterData(name: 'Healty', isSelected: false),
  ];

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = ArticleByCategoryScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            context: context,
            backButton: true,
            title: 'Natural',
            isSearch: true,
            hintSearchText: 'Search Article'),
        body: Column(
          children: [
            SizedBox(
              height: 35,
              child: _buildFilters(),
            ),
            // Container(
            //   padding: const EdgeInsets.only(left: Dimens.size16),
            //   child: SizedBox(
            //       height: 30,
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (
            //           BuildContext context,
            //           int index,
            //         ) {
            //           return Container(
            //             margin: const EdgeInsets.only(right: 6),
            //             child: const Blink(
            //               height: 30,
            //               width: 60,
            //               isCircle: true,
            //             ),
            //           );
            //         },
            //       )),
            // ),
            divide6,
            divideThick(),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ArticleList(
                    onTap: () {
                      Navigator.pushNamed(context, ArticleByIdScreen.path);
                    },
                    userPicture:
                        'https://avatarfiles.alphacoders.com/952/95227.jpg',
                    userName: 'Jonatan lim',
                    title:
                        'Lorem ipsum dolor sit amet, ctetur adipiscing elit. Donec bibendum.',
                    date: '24 Jul 2022',
                    readingTime: '5 min read',
                    image:
                        'https://images.pexels.com/photos/1144687/pexels-photo-1144687.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  );

                  return const ArticleListLoading();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return divideThick();
                },
              ),
            )
          ],
        ));
  }

  Widget _buildFilters() {
    return ListView(
        padding: const EdgeInsets.only(left: Dimens.size16),
        scrollDirection: Axis.horizontal,
        children: List.generate(filter.length, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 5, bottom: 5),
            // height: Dimens.size20,
            child: CustomChip(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              radius: 100,
              label: filter[index].name,
              labelColor: filter[index].isSelected != true
                  ? Colors.black
                  : Colors.white,
              backgroundColor: filter[index].isSelected != true
                  ? Colors.white
                  : Pallete.primary,
              borderColor: filter[index].isSelected != true
                  ? Pallete.border
                  : Pallete.primary,
              onTap: () {
                setState(() {
                  for (var element in filter) {
                    if (element.name == filter[index].name) {
                      element.isSelected = true;
                    } else {
                      element.isSelected = false;
                    }
                  }
                });

                log(filter[index].name.toString());
                log(filter.toString());

                // final map = <String, dynamic>{};
                // map['type'] = 'ARTICLE';
                // if (_listCategory[index].id != 'all') {
                //   map['category_id'] = _listCategory[index].id;
                // }
                // articleBloc.add(GetFilteredArticleEvent(map));
              },
            ),
          );
        }).toList());
  }
}
