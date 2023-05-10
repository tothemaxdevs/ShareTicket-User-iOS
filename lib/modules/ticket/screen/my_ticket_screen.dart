import 'dart:developer';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/ticket/bloc/ticket/ticket_bloc.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_result/order.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_result/order_ticket_result.dart';
import 'package:shareticket/modules/ticket/screen/my_ticket_detail_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/clipper/dol_dum_clipper.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class MyTicketArgument {
  final String title;

  MyTicketArgument(this.title);
}

class MyTicketScreen extends StatefulWidget {
  final MyTicketArgument? argument;

  const MyTicketScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/MyTicket';
  static const String title = 'MyTicket';

  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  String? title;
  TextEditingController searchController = TextEditingController();

  late TicketBloc _ticketBloc;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = MyTicketScreen.title;
    }
    _ticketBloc = TicketBloc();
    _ticketBloc.add(GetTicketOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.screenBackground,
        appBar: appBar(
            context: context,
            title: 'MyTicket',
            // isSearch: true,
            // hintSearchText: 'Cari',
            textEditSearchController: searchController),
        body:

            // Center(
            //   child: IllustrationWidget(
            //     illustration: 'ic_illustration_empty.svg',
            //     showButton: false,
            //     title: 'Kosong',
            //     description: 'Belum ada pesanan dibuat',
            //   ),
            // )

            BlocProvider(
          create: (context) => _ticketBloc,
          child: BlocConsumer<TicketBloc, TicketState>(
            builder: (context, state) {
              if (state is GetTicketOrderLoadingState) {
                return buildLoading();
              } else if (state is GetTicketOrderLoadedState) {
                return _buildView(state.data);
              } else if (state is GetTicketOrderErrorState) {
                return TextWidget(state.message);
              } else if (state is GetTicketOrderEmptyState) {
                return Center(
                  child: IllustrationWidget(
                    illustration: 'ic_illustration_empty.svg',
                    showButton: false,
                    title: 'Kosong',
                    description: 'Belum ada pesanan dibuat',
                  ),
                );
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ));
  }

  Widget _buildView(OrderTicketResult data) {
    return RefreshIndicator(
      onRefresh: () async {
        _ticketBloc.add(GetTicketOrderEvent());
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
                itemCount: data.orders!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var order = data.orders![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: Dimens.size10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimens.size16)),
                      child: ClipPath(
                        clipper:
                            TicketPassClipper(position: 122, holeRadius: 16),
                        child: Container(
                          // padding: EdgeInsets.all(Dimens.size8),
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(Dimens.size10),
                              // ),
                              color: Colors.white),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                routeDetail(order);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, bottom: 8, right: 6),
                                    child: NetworkImagePlaceHolder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Dimens.size10)),
                                      imageUrl: order.event!.banner ?? '',
                                      height: 70,
                                      width: 100,
                                    ),
                                  ),
                                  Dash(
                                      direction: Axis.vertical,
                                      length: 70,
                                      dashLength: 3,
                                      dashColor: Colors.grey.shade300),
                                  divideW10,
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          order.event!.title,
                                          ellipsed: true,
                                          weight: FontWeight.w600,
                                          textColor: Pallete.primary,
                                          size: TextWidgetSize.h6,
                                          maxLines: 1,
                                        ),
                                        divide2,
                                        Row(
                                          children: [
                                            // if (order.status == 'not_paid')
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              Dimens.size128)),
                                                  color: colorStatus(order
                                                      .status!
                                                      .toLowerCase())),
                                              child: TextWidget(
                                                stringStatus(order.status!
                                                    .toLowerCase()),
                                                size: TextWidgetSize.h9,
                                                weight: FontWeight.w600,
                                                textColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        divide4,
                                        Row(
                                          children: [
                                            const SvgUI(
                                              'ic_ticket_calendar_list.svg',
                                              width: 18,
                                              height: 18,
                                            ),
                                            divideW4,
                                            TextWidget(
                                              // '${DateFormat("EEEE, d MMM yyyy",
                                              //         "id_ID")
                                              //     .format(order.event!.date!)}',
                                              // '${DateFormat("d MMM", "id_ID").format(order.event!.date!)} - ${DateFormat("d MMM yyyy", "id_ID").format(order.event!.endDate!)}',
                                              order.event!.date ==
                                                      order.event!.endDate
                                                  ? DateFormat(
                                                          "EEEE, d MMM yyyy",
                                                          "id_ID")
                                                      .format(
                                                          order.event!.endDate!)
                                                  : '${DateFormat("d MMM", "id_ID").format(order.event!.date!)} - ${DateFormat("d MMM yyyy", "id_ID").format(order.event!.endDate!)}',
                                              size: TextWidgetSize.h8,
                                              weight: FontWeight.w500,
                                              textColor: Pallete.greyDark,
                                            ),
                                          ],
                                        ),
                                        divide2,
                                        Row(
                                          children: [
                                            const SvgUI(
                                              'ic_ticket_clock_list.svg',
                                              width: 18,
                                              height: 18,
                                            ),
                                            divideW4,
                                            TextWidget(
                                              order.event!.startTime != null &&
                                                      order.event!.endTime !=
                                                          null
                                                  ? '${parseTime(order.event!.startTime!)} - ${parseTime(order.event!.endTime!)}'
                                                  : '-',
                                              size: TextWidgetSize.h8,
                                              weight: FontWeight.w500,
                                              textColor: Pallete.greyDark,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(bottom: Dimens.size10),
          // padding: EdgeInsets.all(Dimens.size8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.size10),
              ),
              color: Colors.white),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Blink(
                  borderRadius: Dimens.size10,
                  height: 64,
                  width: 100,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 15,
                    height: 7.5,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                        color: Pallete.screenBackground),
                  ),
                  const Dash(
                      direction: Axis.vertical,
                      length: 70,
                      dashLength: 3,
                      dashColor: Pallete.screenBackground),
                  Container(
                    width: 15,
                    height: 7.5,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100)),
                        color: Pallete.screenBackground),
                  )
                ],
              ),
              divide10,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Blink(height: 16, width: 160),
                    divide2,
                    const Blink(height: 10, width: 140),
                    divide4,
                    Row(
                      children: [
                        const Blink(
                          height: 17,
                          width: 17,
                          borderRadius: 4,
                        ),
                        divideW4,
                        const Blink(height: 10, width: 80),
                      ],
                    ),
                    divide2,
                    Row(
                      children: [
                        const Blink(
                          height: 17,
                          width: 17,
                          borderRadius: 4,
                        ),
                        divideW4,
                        const Blink(height: 10, width: 80),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> routeDetail(Order order) async {
    log(order.id!);
    var isUpdate = await Navigator.pushNamed(context, MyTicketDetailScreen.path,
        arguments: MyTicketDetailArgument(orderId: order.id));

    if (isUpdate == true) {
      _ticketBloc.add(GetTicketOrderEvent());
    }
  }
}

String parseTime(String value) {
  DateTime dateTime = DateFormat('HH:mm:ss').parse(value);
  String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedTime;
}

Color colorStatus(String status) {
  if (status == 'paid') {
    return Colors.green;
  } else if (status == 'not_paid') {
    return Colors.orange;
  } else if (status == 'expired_paid') {
    return Colors.yellow[800]!;
  } else if (status == 'cancel_paid') {
    return Colors.red;
  } else {
    return Colors.red;
  }
}

String stringStatus(String status) {
  if (status == 'paid') {
    return 'Selesai';
  } else if (status == 'not_paid') {
    return 'Menunggu pembayaran';
  } else if (status == 'expired_paid') {
    return 'Kadaluarsa';
  } else if (status == 'cancel_paid') {
    return 'Dibatalkan';
  } else {
    return status.replaceAll('_', ' ').toTitleCase();
  }
}
