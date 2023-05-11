import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/main.dart';
import 'package:shareticket/modules/event/screen/event_detail_screen.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/model/event_result/event.dart';
import 'package:shareticket/modules/home/model/event_result/event_result.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/refresh/pull_refresh_widget.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

enum EventMode { category, group }

class EventArgument {
  final String? title;
  final String? cityId;
  final String? id;
  EventMode eventMode;
  EventArgument({this.title, this.cityId, this.id, required this.eventMode});
}

class EventScreen extends StatefulWidget {
  final EventArgument? argument;

  const EventScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/Event';
  static const String title = 'Event';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String? title;

  final Map<String, dynamic> _params = Map();
  late HomeBloc _homeBloc;
  int? currentPage = 1;

  List<Event> listEvent = [];

  LoadStatus? indicatorMode;

  bool? isFirstLaunch = true;
  bool? isMaximum = false;
  PageMode statePageViewData = PageMode.loading;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = EventScreen.title;
    }

    if (widget.argument!.eventMode == EventMode.category) {
      if (widget.argument!.cityId != null) {
        _params['city_id'] = widget.argument!.cityId;
      }

      if (widget.argument!.id != null) {
        _params['category_id'] = widget.argument!.id;
      }
    } else {
      _params['event_group_id'] = widget.argument!.id;
    }

    _homeBloc = HomeBloc();
    _homeBloc.add(GetEventEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(
            context: context, backButton: true, title: widget.argument!.title),
        body: BlocProvider(
          create: (context) => _homeBloc,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              // if (state is GetEventLoadingState) {
              //   return buildLoading();
              // } else if (state is GetEventLoadedState) {
              //   return _buildView(state.data!);
              // } else if (state is GetEventErrorState) {
              //   return TextWidget(state.message);
              // } else if (state is GetEventEmptyState) {
              //   return Center(
              //     child: IllustrationWidget(
              //       illustration: 'ic_illustration_empty.svg',
              //       showButton: false,
              //       title: 'Kosong',
              //       description: 'Tidak ada event',
              //     ),
              //   );
              // }
              return stateView(statePageViewData);
            },
            listener: (context, state) => {
              if (state is GetEventLoadingState)
                {
                  indicatorMode = state.loadStatus,
                  if (isFirstLaunch!) {statePageViewData = state.status!}
                }
              else if (state is GetEventLoadedState)
                {
                  for (var item in state.data!.events!) {listEvent.add(item)},
                  indicatorMode = state.loadStatus,
                  statePageViewData = state.status!,
                  isFirstLaunch = false,
                  refreshController.loadComplete(),
                  refreshController.refreshCompleted()
                }
              else if (state is GetEventErrorState)
                {
                  indicatorMode = state.loadStatus,
                  statePageViewData = state.status!
                }
              else if (state is GetEventEmptyState)
                {
                  indicatorMode = state.loadStatus,
                  statePageViewData = state.status!
                }
              else if (state is GetEventMaximumPageState)
                {indicatorMode = state.loadStatus, isMaximum = true}
            },
          ),
        ));
  }

  stateView(PageMode? pageView) {
    if (pageView == PageMode.loading) {
      return buildLoading();
    } else if (pageView == PageMode.loaded) {
      return _buildView();
    } else if (pageView == PageMode.empty) {
      return IllustrationWidget(
        type: IllustrationWidgetType.empty,
      );
    } else if (pageView == PageMode.error) {
      return IllustrationWidget(
        type: IllustrationWidgetType.error,
        onButtonTap: () {
          refreshBloc();
        },
      );
    }
  }

  refreshBloc() {
    setState(() {
      isMaximum = false;
      currentPage = 1;
      listEvent = [];
      isFirstLaunch = true;
    });
    _params['page'] = currentPage;
    _homeBloc.add(GetEventEvent(_params));
  }

  loadMore() {
    setState(() {
      currentPage = currentPage! + 1;
    });

    if (!isMaximum!) {
      _params['page'] = currentPage;
      _homeBloc.add(GetEventEvent(_params));
    }
  }

  Widget _buildView() {
    return PullRefreshWidget(
      controller: refreshController,
      indicatorMode: indicatorMode,
      child: ListView.builder(
        padding: const EdgeInsets.all(Dimens.size16),
        itemCount: listEvent.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var event = listEvent[index];
          return EventWidget(
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
              price: '0');
        },
      ),
    );
  }

  Widget buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimens.size16),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: Dimens.size10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.size10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Blink(
                width: double.infinity,
                height: 170,
                borderRadius: 10,
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
                        // Blink(
                        //   height: 16,
                        //   width: 80,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EventWidget extends StatelessWidget {
  final String thumbnail, title, date, eventType, price;
  final Function()? onTap;
  const EventWidget({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.date,
    required this.eventType,
    required this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.size10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.size6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Dimens.size10)),
                  child: AspectRatio(
                    aspectRatio: 2 / 1,
                    child: NetworkImagePlaceHolder(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        // height: 170,
                        imageUrl: thumbnail),
                  ),
                ),
                divide2,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.size4, horizontal: Dimens.size10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        title,
                        ellipsed: true,
                        weight: FontWeight.bold,
                        size: TextWidgetSize.h6,
                        textColor: Pallete.primary,
                      ),
                      TextWidget(
                        date,
                        ellipsed: true,
                        weight: FontWeight.w500,
                        size: TextWidgetSize.h8,
                        textColor: Colors.grey,
                      ),
                      divide4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            eventType,
                            size: TextWidgetSize.h6,
                            weight: FontWeight.w500,
                            textColor: Colors.green,
                          ),
                          // TextWidget(
                          //   rupiahFormatter(value: price),
                          //   textColor: Colors.red,
                          //   size: TextWidgetSize.h6,
                          //   weight: FontWeight.bold,
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
