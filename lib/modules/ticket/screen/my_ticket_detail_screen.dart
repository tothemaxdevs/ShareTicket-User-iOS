import 'dart:developer';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/component/dash_divider.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/event/screen/payment_screen.dart';
import 'package:shareticket/modules/ticket/bloc/ticket/ticket_bloc.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_by_id_result/order_ticket_by_id_result.dart';
import 'package:shareticket/modules/ticket/screen/my_ticket_screen.dart';
import 'package:shareticket/modules/ticket/screen/ticket_detail_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/modules/ticket/model/order_ticket_by_id_result/order_detail.dart';

class MyTicketDetailArgument {
  final String? title;
  final String? orderId;

  MyTicketDetailArgument({this.title, this.orderId});
}

class MyTicketDetailScreen extends StatefulWidget {
  final MyTicketDetailArgument? argument;

  const MyTicketDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/myticket/detail';
  static const String title = 'Ticket detail';

  @override
  _MyTicketDetailScreenState createState() => _MyTicketDetailScreenState();
}

class _MyTicketDetailScreenState extends State<MyTicketDetailScreen> {
  String? title;
  String? pageView = 'loading';
  bool? isLoadingCancel = false;
  late TicketBloc ticketBloc;
  OrderTicketByIdResult dataResult = OrderTicketByIdResult();
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = MyTicketDetailScreen.title;
    }

    ticketBloc = TicketBloc();
    ticketBloc.add(GetTicketOrderByIdEvent(widget.argument!.orderId!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: CustomScaffold(
          appBar: appBar(
            context: context,
            title: 'Ticket detail',
            backButton: true,
            onBackTap: () {
              Navigator.pop(context, true);
            },
          ),
          body: BlocProvider(
            create: (context) => ticketBloc,
            child: BlocConsumer<TicketBloc, TicketState>(
              builder: (context, state) {
                if (state is GeTicketOrderByIdLoadingState) {
                  return loading();
                } else if (state is GeTicketOrderByIdLoadedState) {
                  return _buildView(state.data);
                } else if (state is GeTicketOrderByIdErrorState) {
                  return TextWidget(state.message);
                }
                return statePageView(pageView);
              },
              listener: (context, state) => {
                if (state is GeTicketOrderByIdLoadingState)
                  {
                    pageView = 'loading',
                  }
                else if (state is GeTicketOrderByIdLoadedState)
                  {
                    setState(
                      () {
                        dataResult = state.data;
                      },
                    ),
                    pageView = 'loaded',
                    if (state.data.orders!.virtualAccount != null)
                      {
                        ticketBloc.add(
                            PostUpdateStatusEvent(widget.argument!.orderId))
                      }
                  }
                else if (state is GeTicketOrderByIdErrorState)
                  {
                    pageView = 'error',
                  }
                else if (state is PostUpdateStatusLoadingState)
                  {}
                else if (state is PostUpdateStatusLoadedState)
                  {
                    log('Callback success'),
                  }
                else if (state is PostUpdateStatusErrorState)
                  {
                    log('Callback error'),
                  }
                else if (state is PostUpdateStatusFailedState)
                  {
                    log('Callback failed'),
                  }
                else if (state is PostCancelOrderLoadingState)
                  {
                    setState(() {
                      isLoadingCancel = true;
                    })
                  }
                else if (state is PostCancelOrderLoadedState)
                  {
                    log('Cancel success'),
                    setState(() {
                      isLoadingCancel = false;
                    }),
                    ticketBloc
                        .add(GetTicketOrderByIdEvent(widget.argument!.orderId!))
                  }
                else if (state is PostCancelOrderErrorState)
                  {
                    log('Cancel error'),
                    setState(() {
                      isLoadingCancel = false;
                    }),
                    showToastError('Gagal membatalkan pesanan!')
                  }
                else if (state is PostCancelOrderFailedState)
                  {
                    log('Cancel failed'),
                    setState(() {
                      isLoadingCancel = false;
                    }),
                    showToastError('Gagal membatalkan pesanan!')
                  }
              },
            ),
          )),
    );
  }

  statePageView(String? type) {
    if (type == 'loading') {
      return loading();
    } else if (type == 'loaded') {
      return _buildView(dataResult);
    } else if (type == 'error') {
      return IllustrationWidget(
        type: IllustrationWidgetType.error,
        onButtonTap: () {
          ticketBloc.add(GetTicketOrderByIdEvent(widget.argument!.orderId!));
        },
      );
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, true);
    return true;
  }

  Widget _buildView(OrderTicketByIdResult data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.size20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimens.size16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 3.4 / 2.5,
                          child: NetworkImagePlaceHolder(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimens.size10)),
                            imageUrl: data.orders!.event!.banner!,
                          ),
                        ),
                        divide10,
                        TextWidget(
                          data.orders!.event!.title,
                          weight: FontWeight.bold,
                          textColor: Pallete.primary,
                          size: TextWidgetSize.h5,
                        ),
                        divide6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(Dimens.size128)),
                                  color: colorStatus(
                                      data.orders!.status!.toLowerCase())),
                              child: TextWidget(
                                stringStatus(
                                    data.orders!.status!.toLowerCase()),
                                size: TextWidgetSize.h8,
                                weight: FontWeight.w600,
                                textColor: Colors.white,
                              ),
                            ),
                            RoundedButton(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 10,
                                ),
                                heigth: 24,
                                textSize: 11,
                                text: 'Lihat detail',
                                textColor: Pallete.primary,
                                color: Colors.white,
                                borderColor: Pallete.primary,
                                press: () {
                                  bottomSheet(
                                    context: context,
                                    child: Expanded(
                                        child: TicketDetailScreen(
                                      eventId: data.orders!.event!.id!,
                                    )),
                                  );
                                })
                          ],
                        ),
                        divide6,
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: detailOrder(
                                    title: 'Nama',
                                    subtitle: data.orders!.user!.name!)),
                            divide10,
                            Flexible(
                                fit: FlexFit.tight,
                                child: detailOrder(
                                  title: 'Waktu',
                                  subtitle: data.orders!.event!.startTime !=
                                              null &&
                                          data.orders!.event!.endTime != null
                                      ? '${parseTime(data.orders!.event!.startTime!)} - ${parseTime(data.orders!.event!.endTime!)}'
                                      : '-',
                                )),
                          ],
                        ),
                        divide20,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: detailOrder(
                                  title: 'Tanggal',
                                  subtitle: data.orders!.event!.date ==
                                          data.orders!.event!.endDate
                                      ? DateFormat("EEEE, d MMM yyyy", "id_ID")
                                          .format(data.orders!.event!.endDate!)
                                      : '${DateFormat("d MMM", "id_ID").format(data.orders!.event!.date!)} - ${DateFormat("d MMM yyyy", "id_ID").format(data.orders!.event!.endDate!)}',
                                )),
                            divide10,
                            Flexible(
                                fit: FlexFit.tight,
                                child: detailOrder(
                                  title: 'Tiket',
                                  withButton: data.orders!.orderDetail!.isEmpty
                                      ? false
                                      : data.orders!.status!.toLowerCase() ==
                                          'paid',
                                  onTap: () {
                                    orderList(
                                        orderDetail: data.orders!.orderDetail,
                                        subTotal: data.orders!.subtotal,
                                        discount: data.orders!.discount,
                                        totalOrder:
                                            data.orders!.total.toString());
                                  },
                                  subtitle: data.orders!.orderDetail!.isEmpty
                                      ? 'Tidak ada detail tiket'
                                      : data.orders!.orderDetail!.length > 1
                                          ? '${data.orders!.orderDetail![0].quantity}x Tiket ${data.orders!.orderDetail![0].ticket!.title}, dan ${data.orders!.orderDetail!.length - 1} lainnya'
                                          : '${data.orders!.orderDetail![0].quantity}x Tiket ${data.orders!.orderDetail![0].ticket!.title}',
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _dividerTicket(),
                  _buttonView(data),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _dividerTicket() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 10,
          height: 20,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
              color: Pallete.screenBackground),
        ),
        Flexible(
          child: DashDivider(
            color: Colors.grey.shade200,
          ),
        ),
        Container(
          width: 10,
          height: 20,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100)),
              color: Pallete.screenBackground),
        )
      ],
    );
  }

  Widget detailOrder(
      {required String title,
      required String subtitle,
      bool? withButton = false,
      Function()? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title,
          size: TextWidgetSize.h7,
          weight: FontWeight.w500,
          textColor: Colors.grey,
        ),
        TextWidget(
          subtitle,
          size: TextWidgetSize.h7,
          textColor: Pallete.primary,
          weight: FontWeight.w600,
          ellipsed: true,
          maxLines: 2,
        ),
        if (withButton == true)
          GestureDetector(
            onTap: onTap,
            child: TextWidget(
              'Lihat detail',
              size: TextWidgetSize.h7,
              textColor: Colors.green,
              weight: FontWeight.w600,
            ),
          )
      ],
    );
  }

  orderList(
      {List<OrderDetail>? orderDetail,
      String? totalOrder,
      int? subTotal,
      int? discount}) {
    bottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height * 0.7,
        title: 'List Order',
        child: Expanded(
            child: ListView(
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderDetail!.length,
              itemBuilder: (BuildContext context, int index) {
                var subTotal = orderDetail[index];
                return ListTile(
                  title: TextWidget(
                    '${subTotal.ticket!.title}',
                    size: TextWidgetSize.h6,
                    weight: FontWeight.w500,
                    textColor: Pallete.primary,
                    maxLines: 2,
                    ellipsed: true,
                  ),
                  trailing: TextWidget(
                    '${rupiahFormatter(value: subTotal.totalPrice.toString())}\n(x${subTotal.quantity})',
                    size: TextWidgetSize.h6,
                    textAlign: TextAlign.right,
                    weight: FontWeight.w500,
                    textColor: Pallete.primary,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return divideThick();
              },
            ),
            divideThick(),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.size16,
                  right: Dimens.size16,
                  top: Dimens.size8,
                  bottom: Dimens.size16),
              child: Column(
                children: [
                  if (subTotal != 0)
                    orderAmoutDetail(
                        title: 'Subtotal',
                        amount: subTotal.toString(),
                        isBold: false),
                  if (discount != 0)
                    orderAmoutDetail(
                        title: 'Potongan',
                        amount: discount.toString(),
                        wihtMin: true,
                        isBold: false),
                  orderAmoutDetail(
                      title: 'Total', amount: totalOrder.toString()),
                ],
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: Dimens.size16,
            //       right: Dimens.size16,
            //       top: Dimens.size8,
            //       bottom: Dimens.size16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       TextWidget(
            //         'Total',
            //         size: TextWidgetSize.h6,
            //         weight: FontWeight.bold,
            //         textColor: Pallete.primary,
            //       ),
            //       TextWidget(
            //         rupiahFormatter(value: totalOrder.toString()),
            //         size: TextWidgetSize.h6,
            //         weight: FontWeight.w500,
            //         textColor: Pallete.primary,
            //       )
            //     ],
            //   ),
            // ),
          ],
        )));
  }

  Widget _buttonView(OrderTicketByIdResult data) {
    if (data.orders!.status!.toLowerCase() == 'paid') {
      return Padding(
        padding: const EdgeInsets.all(Dimens.size16),
        child: BarcodeWidget(
          barcode: Barcode.qrCode(), // Barcode type and settings
          data: data.orders!.virtualAccount != null
              ? data.orders!.virtualAccount!.externalId!
              : data.orders!.qris!.externalId!, // Content
          height: MediaQuery.of(context).size.width * 0.50,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Dimens.size12,
              color: Colors.white),
        ),
      );
    } else if (data.orders!.status!.toLowerCase() == 'not_paid') {
      return Column(
        children: [
          _orderDetail(data: data, title: 'Pesanan belum dibayar'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                RoundedButton(
                    text: 'Bayar sekarang',
                    width: double.infinity,
                    press: () {
                      Navigator.pushNamed(context, PaymentScreen.path,
                          arguments: PaymentArgument(
                              orderId: data.orders!.id!,
                              bankCode: data.orders!.virtualAccount != null
                                  ? data.orders!.virtualAccount!.bankCode!
                                  : 'QRIS'));
                    }),
                divide16,
                if (data.orders!.virtualAccount != null)
                  RoundedButton(
                      isLoading: isLoadingCancel!,
                      text: 'Batalkan Pesanan',
                      width: double.infinity,
                      textColor: Colors.red,
                      color: Colors.transparent,
                      borderColor: Colors.transparent,
                      press: () {
                        cancelDialog(context);
                      }),
              ],
            ),
          ),
        ],
      );
    } else if (data.orders!.status!.toLowerCase() == 'expired_paid') {
      return _orderDetail(data: data, title: 'Pesanan kadaluarsa');
    } else if (data.orders!.status!.toLowerCase() == 'cancel_paid') {
      return _orderDetail(data: data, title: 'Pesanan dibatalkan');
    } else {
      return _orderDetail(data: data, title: 'Pesanan belum dibayar');
    }
  }

  Widget _orderDetail({required OrderTicketByIdResult data, String? title}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(
            left: Dimens.size16,
            right: Dimens.size16,
            top: Dimens.size8,
            bottom: Dimens.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              title ?? 'Pesanan belum dibayar',
              textColor: Pallete.primary,
              weight: FontWeight.w600,
              size: TextWidgetSize.h6,
            ),
            divide10,
            if (data.orders!.orderDetail!.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.orders!.orderDetail!.length,
                itemBuilder: (BuildContext context, int index) {
                  var subTotal = data.orders!.orderDetail![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimens.size4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            '${subTotal.quantity}x ${subTotal.ticket!.title}',
                            size: TextWidgetSize.h6,
                            weight: FontWeight.w500,
                            textColor: Pallete.primary,
                            maxLines: 1,
                            ellipsed: true,
                          ),
                        ),
                        TextWidget(
                          rupiahFormatter(
                              value: subTotal.totalPrice.toString()),
                          size: TextWidgetSize.h6,
                          weight: FontWeight.w500,
                          textColor: Pallete.primary,
                        )
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      _dividerTicket(),
      Padding(
        padding: const EdgeInsets.only(
            left: Dimens.size16,
            right: Dimens.size16,
            top: Dimens.size8,
            bottom: Dimens.size16),
        child: Column(
          children: [
            if (data.orders!.subtotal != 0)
              orderAmoutDetail(
                  title: 'Subtotal',
                  amount: data.orders!.subtotal.toString(),
                  isBold: false),
            if (data.orders!.discount != 0)
              orderAmoutDetail(
                  title: 'Potongan',
                  amount: data.orders!.discount.toString(),
                  wihtMin: true,
                  isBold: false),
            orderAmoutDetail(
                title: 'Total', amount: data.orders!.total.toString()),
          ],
        ),
      )
    ]);
  }

  Widget orderAmoutDetail(
      {required String title,
      required String amount,
      bool isBold = true,
      bool wihtMin = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimens.size4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title,
            size: TextWidgetSize.h6,
            weight: isBold ? FontWeight.w600 : FontWeight.w500,
            textColor: Pallete.primary,
          ),
          TextWidget(
            wihtMin
                ? '-${rupiahFormatter(value: amount)}'
                : rupiahFormatter(value: amount),
            size: TextWidgetSize.h6,
            weight: isBold ? FontWeight.w600 : FontWeight.w500,
            textColor: Pallete.primary,
          )
        ],
      ),
    );
  }

  cancelDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          title: 'Batalkan pesanan',
          descriptions: 'Apakah anda yakin ingin membatalkan pesanan ini?',
          enableCancel: true,
          onCancelText: 'Tidak',
          onOkText: 'Batalkan',
          onOkTap: () {
            Navigator.pop(context);
            postToServer();
          },
        );
      },
    );
  }

  postToServer() {
    Map<String, dynamic> body = {};

    body['order_id'] = widget.argument!.orderId;

    ticketBloc.add(PostCancelOrderEvent(body: body));
  }
}
