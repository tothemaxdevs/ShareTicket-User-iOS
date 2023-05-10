import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/event/screen/event_list_screen.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/section_tile.dart';
import 'package:shareticket/modules/home/model/category_result/category_result.dart';
import 'package:shareticket/modules/home/model/event_group_result/event_group_result.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class EventGroupWidget extends StatefulWidget {
  final String title;
  const EventGroupWidget({Key? key, required this.title}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventGroupWidget> {
  final Map<String, dynamic> _params = Map();
  HomeBloc? homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc();
    homeBloc!.add(GetEventGroupEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetEventGroupLoadingState) {
                return buildLoading();
              } else if (state is GetEventGroupLoadedState) {
                return _buildView(state.data);
              } else if (state is GetEventGroupErrorState) {
                return const SizedBox();
              } else if (state is GetEventGroupEmtptyState) {
                return const SizedBox();
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ),
      ],
    );
  }

  Column _buildView(EventGroupResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        divide6,
        SectionTile(
          title: widget.title,
        ),
        divide6,
        SizedBox(
          height: 190,
          child: ListView.builder(
            itemCount: data.eventGroups!.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var category = data.eventGroups![index];
              return Container(
                width: 110,
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
                              eventMode: EventMode.group));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(Dimens.size4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NetworkImagePlaceHolder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              imageUrl: category.icon,
                            ),
                            divide8,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      category.name,
                                      textColor: Pallete.primary,
                                      weight: FontWeight.w600,
                                      maxLines: 2,
                                      ellipsed: true,
                                      size: TextWidgetSize.h7,
                                    ),
                                    TextWidget(
                                      '${category.eventCount} Tenant',
                                      textColor: Pallete.greyDark,
                                      weight: FontWeight.w500,
                                      size: TextWidgetSize.h8,
                                    ),
                                  ],
                                ),
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
          height: 190,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: Dimens.size10),
                  padding: const EdgeInsets.all(Dimens.size4),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.size10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Blink(
                        borderRadius: 8,
                        height: 100,
                        width: 100,
                      ),
                      divide10,
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
