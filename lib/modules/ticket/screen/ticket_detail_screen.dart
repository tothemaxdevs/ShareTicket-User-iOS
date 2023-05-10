import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/event/bloc/event/event_bloc.dart';
import 'package:shareticket/modules/event/component/detail_event_tile.dart';
import 'package:shareticket/modules/event/component/event_desc_widget.dart';
import 'package:shareticket/modules/event/model/maps/location_data.dart';
import 'package:shareticket/modules/event/model/one_event_result/one_event_result.dart';
import 'package:shareticket/modules/event/model/order_model/order_model.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class TicketDetailArgument {
  final String? title;
  final String eventId;

  TicketDetailArgument({this.title, required this.eventId});
}

class TicketDetailScreen extends StatefulWidget {
  final String eventId;
  final TicketDetailArgument? argument;

  const TicketDetailScreen({Key? key, this.argument, required this.eventId})
      : super(key: key);

  static const String path = '/event/detail/ticket';
  static const String title = 'Event detail';

  @override
  _TicketDetailScreenState createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  String? title;
  MapsData? _mapsData;
  OneEventResult? oneEventResult;
  LatLng? _map;
  final Completer<GoogleMapController> _mapController = Completer();
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  ScrollController? _controller;
  bool isPositionMin = true;

  EventBloc? eventBloc;
  int _currentIndex = 0;

  List<OrderModel> packageList = [];

  MarkerId markerId = const MarkerId("1");
  void _onMapScreated(
    GoogleMapController controller,
  ) async {
    controller.showMarkerInfoWindow(markerId);
    _mapController.complete(controller);

    setState(() {
      _map = LatLng(_mapsData!.latitude!, _mapsData!.longitude!);

      Marker marker = Marker(
        markerId: markerId,
        position: _map!,
        draggable: false,
      );
      _markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = TicketDetailScreen.title;
    }

    eventBloc = EventBloc();
    eventBloc!.add(GetOneEventEvent(widget.eventId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocProvider(
          create: (context) => eventBloc!,
          child: BlocConsumer<EventBloc, EventsState>(
            builder: (context, state) {
              if (state is GetOneEventLoadingState) {
                return loading();
              } else if (state is GetOneEventLoadedState) {
                oneEventResult = state.data;
                return _buildView(context, oneEventResult!);
              } else if (state is GetOneEventErrorState) {
                return TextWidget(state.message);
              }
              return Container();
            },
            listener: (context, state) => {
              if (state is GetOneEventLoadedState)
                {
                  setState(
                    () {
                      _mapsData = MapsData(
                          latitude: double.tryParse(state.data.event!.lat!),
                          longitude: double.tryParse(state.data.event!.lng!),
                          placename: state.data.event!.address);
                    },
                  )
                }
            },
          ),
        ),
      ),
    );
  }

  Column _buildView(BuildContext context, OneEventResult data) {
    return Column(
      children: [
        Expanded(
            child: ListView(children: [
          NetworkImagePlaceHolder(
            imageUrl: data.event!.banner,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  data.event!.title,
                  weight: FontWeight.bold,
                  size: TextWidgetSize.h5,
                  textColor: Pallete.primary,
                ),
                divide8,
                DetailEventTile(
                    label: data.event!.address!,
                    icon: 'ic_ticket_location.svg'),
                divide4,
                DetailEventTile(
                    label: DateFormat("EEEE, d MMM yyyy", "id_ID")
                        .format(data.event!.date!),
                    icon: 'ic_ticket_calendar.svg'),
                divide4,
                DetailEventTile(
                    label: data.event!.startTime != null &&
                            data.event!.endTime != null
                        ? '${data.event!.startTime} - ${data.event!.endTime} '
                        : '-',
                    icon: 'ic_ticket_clock.svg'),
                divide4,
                if (data.event!.vendorId != null)
                  DetailEventTile(
                      label: data.event!.vendorId,
                      icon: 'ic_ticket_vendor.svg'),
              ],
            ),
          ),
          EventDescWidget(
            description: data.event!.description,
            title: LocaleKeys.event_description.tr(),
            ifnulltext: 'Tidak ada deskripsi',
          ),
          EventDescWidget(
            description: data.event!.term,
            title: LocaleKeys.event_tnc.tr(),
            ifnulltext: 'Tidak ada syarat dan ketentuan',
          ),
          // OtherInformationWidget(
          //   onPageChanged: (index, reason) {
          //     setState(() {
          //       _currentIndex = index;
          //     });
          //   },
          //   imageList: data.event!.stage,
          //   currentIndex: _currentIndex,
          // ),
          divideThick(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16, vertical: Dimens.size8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      LocaleKeys.event_navigation.tr(),
                      size: TextWidgetSize.h6,
                      weight: FontWeight.w600,
                      textColor: Pallete.primary,
                    ),
                    InkWell(
                      child: TextWidget(
                        LocaleKeys.event_navigation_maps.tr(),
                        size: TextWidgetSize.h6,
                        weight: FontWeight.w600,
                        textColor: Colors.red,
                      ),
                      onTap: () {
                        openMapDialog();
                      },
                    ),
                  ],
                ),
                divide10,
                if (_mapsData!.latitude != null && _mapsData!.longitude != null)
                  InkWell(
                    onTap: () {
                      openMapDialog();
                    },
                    child: SizedBox(
                      height: 130,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimens.size10)),
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          mapToolbarEnabled: false,
                          compassEnabled: false,
                          scrollGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                _mapsData!.latitude!, _mapsData!.longitude!),
                            zoom: 16.0,
                          ),
                          onMapCreated: _onMapScreated,
                          markers: Set<Marker>.of(_markers.values),
                        ),
                      ),
                    ),
                  ),
                divide6,
                TextWidget(
                  _mapsData!.placename,
                  size: TextWidgetSize.h7,
                  textColor: Pallete.primary,
                ),
              ],
            ),
          ),
        ]))
        // divideThick(
        //   height: 10.0,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //       horizontal: Dimens.size16, vertical: Dimens.size8),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       TextWidget(
        //         LocaleKeys.event_tikcet.tr(),
        //         size: TextWidgetSize.h6,
        //         weight: FontWeight.w600,
        //         textColor: Pallete.primary,
        //       ),
        //       divide10,
        //       ListView.builder(
        //         itemCount: data.event!.ticket!.length,
        //         physics: const NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         itemBuilder: (BuildContext context, int index) {
        //           var ticket = data.event!.ticket![index];
        //           return Padding(
        //             padding: const EdgeInsets.only(bottom: Dimens.size10),
        //             child: PackageTile(
        //               orderAmount: ticket.orderAmount ?? 0,
        //               isCounterMode: false,
        //               title: ticket.title!,
        //               price: ticket.price!,
        //               onTapPlus: () {
        //                 setState(() {
        //                   packageList.add(OrderModel(
        //                       proudctid: ticket.id,
        //                       amount: 1,
        //                       ticket: ticket));
        //                   updateProduct();
        //                 });
        //               },
        //               onTapMinus: () {
        //                 packageList.removeWhere(
        //                     (element) => element.proudctid == ticket.id);
        //                 updateProduct();
        //               },
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        //     divideThick(
        //       height: 10.0,
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: Dimens.size16, vertical: Dimens.size10),
        //           child: TextWidget(
        //             LocaleKeys.event_recomendation.tr(),
        //             size: TextWidgetSize.h6,
        //             weight: FontWeight.w600,
        //             textColor: Pallete.primary,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 280,
        //           child: ListView.builder(
        //             physics: const BouncingScrollPhysics(),
        //             padding: const EdgeInsets.symmetric(
        //                 horizontal: Dimens.size16, vertical: Dimens.size10),
        //             shrinkWrap: true,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: (BuildContext context, int index) {
        //               return NearByEventWidget(
        //                 backgroundColor: Colors.grey.shade50,
        //                 thumbnail:
        //                     'https://s-light.tiket.photos/t/01E25EBZS3W0FY9GTG6C42E1SE/rsfit621414gsm/events/2022/06/26/14d28df5-b619-4e27-8280-e889bbaed8d9-1656212080293-8fd0eedce06ba1caf9f8114c4ae2f1ad.jpeg',
        //                 title: 'GUDFEST 2022',
        //                 date: 'Aug 11, 2022 Jakarta',
        //                 price: '250000',
        //                 eventType: 'Concert',
        //               );
        //             },
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // )),
        // ),
        // divideThick(),
        // Container(
        //   padding: const EdgeInsets.all(Dimens.size16),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       if (packageList.isNotEmpty)
        //         Flexible(
        //           fit: FlexFit.tight,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               TextWidget(
        //                 'Package',
        //                 weight: FontWeight.w500,
        //                 size: TextWidgetSize.h7,
        //                 textColor: Pallete.greyDark,
        //               ),
        //               TextWidget(
        //                   packageList.length == 1
        //                       ? '${packageList[0].ticket!.title} ${packageList[0].ticket!.orderAmount}pcs'
        //                       : '${packageList[0].ticket!.title} ${packageList[0].ticket!.orderAmount}pcs, ${packageList.length - 1} more',
        //                   weight: FontWeight.bold,
        //                   textColor: Pallete.primary,
        //                   size: TextWidgetSize.h7),
        //             ],
        //           ),
        //         ),
        //       Flexible(
        //         fit: FlexFit.tight,
        //         child: RoundedButton(
        //           text: LocaleKeys.core_continue.tr(),
        //           press: packageList.isNotEmpty
        //               ? () async {
        //                   var isUpdated = await Navigator.pushNamed(
        //                       context, OrderDetailScreen.path,
        //                       arguments: OrderDetailArgument(
        //                           packageList: packageList,
        //                           eventId: data.event!.id));

        //                   if (isUpdated == true) {
        //                     updateProduct();
        //                   }
        //                 }
        //               : null,
        //           width: packageList.isNotEmpty ? 150 : double.infinity,
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }

  // updateProduct() {
  //   log('update loaded');
  //   setState(() {
  //     for (var item in oneEventResult!.event!.ticket!) {
  //       item.orderAmount =
  //           packageList.indexWhere((element) => element.proudctid == item.id) !=
  //                   -1
  //               ? packageList[packageList
  //                       .indexWhere((element) => element.proudctid == item.id)]
  //                   .amount
  //               : 0;
  //     }
  //     // COUNTING PRODUCT
  //   });
  // }

  void openMapDialog() {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          enableCancel: true,
          title: 'Buka maps',
          descriptions: 'Apakah anda ingin membuka google maps?',
          onCancelText: 'Batal',
          onOkText: 'Buka',
          onOkTap: () {
            openMap(_mapsData!.latitude!, _mapsData!.longitude!);
          },
        );
      },
    );
  }
}
