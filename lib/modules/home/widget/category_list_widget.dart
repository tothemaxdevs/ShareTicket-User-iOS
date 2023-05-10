import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/event/screen/event_list_screen.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/section_tile.dart';
import 'package:shareticket/modules/home/model/category_result/category_result.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class CategoryListWidget extends StatefulWidget {
  final String title;
  const CategoryListWidget({Key? key, required this.title}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<CategoryListWidget> {
  final Map<String, dynamic> _params = Map();
  HomeBloc? homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc();
    homeBloc!.add(GetCategoryEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        divide6,
        SectionTile(
          title: widget.title,
        ),
        divide6,
        BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetEventCategoryLoadingState) {
                return buildLoading();
              } else if (state is GetEventCategoryLoadedState) {
                return _buildView(state.data);
              } else if (state is GetEventCategoryErrorState) {
                return TextWidget(state.message);
              } else if (state is GetEventCategoryEmtptyState) {
                return TextWidget('Empty');
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ),
      ],
    );
  }

  Column _buildView(CategoryResult data) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: ListView.builder(
            itemCount: data.eventCategories!.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var category = data.eventCategories![index];
              return Container(
                width: 130,
                height: 60,
                margin: const EdgeInsets.only(right: Dimens.size10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.size10))),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(Dimens.size10)),
                    onTap: () {
                      Navigator.pushNamed(context, EventScreen.path,
                          arguments: EventArgument(
                            title: category.name,
                            id: category.id,
                            eventMode: EventMode.category,
                          ));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(Dimens.size4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NetworkImagePlaceHolder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              imageUrl: category.icon,
                            ),
                            divideW8,
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    category.name,
                                    textColor: Pallete.primary,
                                    weight: FontWeight.w600,
                                    maxLines: 1,
                                    ellipsed: true,
                                    size: TextWidgetSize.h7,
                                  ),
                                  TextWidget(
                                    '${category.eventCount} Event',
                                    textColor: Pallete.greyDark,
                                    weight: FontWeight.w500,
                                    size: TextWidgetSize.h8,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildLoading() {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 130,
                  height: 60,
                  margin: const EdgeInsets.only(right: Dimens.size10),
                  padding: const EdgeInsets.all(Dimens.size4),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.size10))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Blink(
                        borderRadius: 8,
                        height: 45,
                        width: 45,
                      ),
                      divideW8,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Blink(height: 10, width: 40),
                          divide2,
                          const Blink(height: 10, width: 35),
                        ],
                      )
                    ],
                  ));
            },
          ),
        )
      ],
    );
  }
}
