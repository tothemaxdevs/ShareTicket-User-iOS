import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/event/screen/event_list_screen.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/nearby_event_widget.dart';
import 'package:shareticket/modules/home/component/popular_event_widget.dart';
import 'package:shareticket/modules/home/component/section_tile.dart';
import 'package:shareticket/modules/home/model/event_result/event_result.dart';
import 'package:shareticket/modules/event/screen/event_detail_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class EventListWidget extends StatefulWidget {
  final bool isLarge;
  final String title;
  final HomeBloc homeBloc;
  final String? cityId;
  final bool? wihtTitle;
  final Color? backgroundColor;
  const EventListWidget(
      {Key? key,
      required this.isLarge,
      required this.title,
      required this.homeBloc,
      this.cityId,
      this.wihtTitle = true,
      this.backgroundColor})
      : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventListWidget> {
  // HomeBloc? homeBloc;

  @override
  void initState() {
    // homeBloc = widget.homeBloc;
    // homeBloc!.add(GetEventEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.wihtTitle == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              divide6,
              SectionTile(
                title: widget.title,
                onSubTap: () {
                  Navigator.pushNamed(context, EventScreen.path,
                      arguments: EventArgument(
                          cityId: widget.cityId,
                          title: widget.title,
                          eventMode: EventMode.category));
                },
              ),
              divide6,
            ],
          ),
        BlocProvider(
          create: (context) => widget.homeBloc,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetEventListWidgetLoadingState) {
                return buildLoading();
              } else if (state is GetEventListWidgetLoadedState) {
                return _buildView(state.data);
              } else if (state is GetEventListWidgetErrorState) {
                return TextWidget(state.message);
              } else if (state is GetEventListWidgetEmptyState) {
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.size16),
                    child: TextWidget(
                      'Empty',
                      weight: FontWeight.w600,
                      textColor: Pallete.greyDark,
                    ));
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ),
      ],
    );
  }

  Widget _buildView(EventResult data) {
    return SizedBox(
      height: widget.isLarge ? 280 : 280,
      child: ListView.builder(
        itemCount: data.events!.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.size16, vertical: Dimens.size10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var event = data.events![index];

          return widget.isLarge
              ? PopularEventWidget(
                  onTap: () async {
                    Navigator.pushNamed(context, EventDetailScreen.path,
                        arguments: EventDetailArgument(
                            eventId: event.id!,
                            cityId: await LocalStorageService.getCity()));
                  },
                  thumbnail: event.banner!,
                  title: event.title!,
                  date: event.date == event.endDate
                      ? DateFormat("EEEE, d MMM yyyy", "id_ID")
                          .format(event.endDate!)
                      : '${DateFormat("d MMM", "id_ID").format(event.date!)} - ${DateFormat("d MMM yyyy", "id_ID").format(event.endDate!)}',
                  eventType: event.category!.name!,
                  price: '0')
              : NearByEventWidget(
                  backgroundColor: widget.backgroundColor,
                  onTap: () async {
                    Navigator.pushNamed(context, EventDetailScreen.path,
                        arguments: EventDetailArgument(
                            eventId: event.id!,
                            cityId: await LocalStorageService.getCity()));
                  },
                  thumbnail: event.banner!,
                  title: event.title!,
                  date: event.date == event.endDate
                      ? DateFormat("EEEE, d MMM yyyy", "id_ID")
                          .format(event.endDate!)
                      : '${DateFormat("d MMM", "id_ID").format(event.date!)} - ${DateFormat("d MMM yyyy", "id_ID").format(event.endDate!)}',
                  price: '0',
                  eventType: event.category!.name!,
                );
        },
      ),
    );
  }

  Widget buildLoading() {
    return SizedBox(
      height: widget.isLarge ? 255 : 280,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.size16, vertical: Dimens.size10),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return widget.isLarge
              ? Container(
                  margin: const EdgeInsets.only(right: Dimens.size10),
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.size10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.size10)),
                        child: Blink(
                          width: 300,
                          height: 170,
                        ),
                      ),
                      divide2,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.size4, horizontal: Dimens.size10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Blink(
                              height: 18,
                              width: 140,
                            ),
                            divide2,
                            const Blink(
                              height: 12,
                              width: 180,
                            ),
                            divide4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Blink(
                                  height: 16,
                                  width: 80,
                                ),
                                Blink(
                                  height: 16,
                                  width: 80,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: Dimens.size10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.size10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Blink(
                          width: 150, height: 180, borderRadius: Dimens.size10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Blink(height: 20, width: 130),
                            divide4,
                            const Blink(height: 14, width: 80),
                            divide2,
                            const Blink(height: 18, width: 90)
                          ],
                        ),
                      ),
                    ],
                  ));
        },
      ),
    );
  }
}
