import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/component/dash_divider.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/event/bloc/event/event_bloc.dart';
import 'package:shareticket/modules/event/model/order_model/order_model.dart';
import 'package:shareticket/modules/event/model/voucher_detail_result/voucher_detail_result.dart';
import 'package:shareticket/modules/event/screen/payment_method_screen.dart';
import 'package:shareticket/modules/event/screen/payment_screen.dart';
import 'package:shareticket/modules/event/widget/package_tile.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/modules/event/model/va_list_result/virtual_account.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class OrderDetailArgument {
  final String? title;
  final String? eventId;
  final String? categoryId;
  final String? description;
  List<OrderModel> packageList = [];
  List<String> paymentMode;

  OrderDetailArgument(
      {this.title,
      required this.packageList,
      this.eventId,
      this.description,
      this.categoryId,
      required this.paymentMode});
}

class OrderDetailScreen extends StatefulWidget {
  final OrderDetailArgument? argument;

  const OrderDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/order/detail';
  static const String title = 'Order detail';

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? title;

  VirtualAccount? virtualAccount;

  List<OrderModel>? orderList = [];
  List<SubtotalModel>? subtotalModel = [];
  int totalOrder = 0;
  int discountOrder = 0;

  TextEditingController discountController = TextEditingController();

  bool isLoading = false;
  bool isLoadingVoucher = false;
  bool isVoucherUsed = false;
  EventBloc? eventBloc;
  VoucherDetailResult? dataVoucher;
  @override
  void initState() {
    orderList = widget.argument!.packageList;
    eventBloc = EventBloc();
    updateCalculation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: appBar(
                context: context,
                backButton: true,
                title: LocaleKeys.order_title.tr()),
            body: BlocProvider(
              create: (context) => eventBloc!,
              child: BlocConsumer<EventBloc, EventsState>(
                builder: (context, state) {
                  return _buildView(context);
                },
                listener: (context, state) => {
                  if (state is CreateOrderLoadingState)
                    {isLoading = true}
                  else if (state is CreateOrderFailedState)
                    {
                      isLoading = false,
                      showToastError('Gagal membuat pesanan, coba lagi.'),
                      log(state.message.data.toString())
                    }
                  else if (state is CreateOrderErrorState)
                    {isLoading = false, showToast(state.message)}
                  else if (state is CreateOrderLoadedState)
                    {
                      Navigator.pushReplacementNamed(
                          context, PaymentScreen.path,
                          arguments: PaymentArgument(
                              orderId: state.data,
                              bankCode: virtualAccount!.code!))
                    }
                  else if (state is GetVoucherDetailLoadingState)
                    {isLoadingVoucher = true}
                  else if (state is GetVoucherDetailFailedState)
                    {isLoadingVoucher = false, showToastError(state.message)}
                  else if (state is GetVoucherDetailErrorState)
                    {isLoadingVoucher = false, showToast(state.message)}
                  else if (state is GetVoucherDetailLoadedState)
                    {
                      isLoadingVoucher = false,
                      if (state.data.voucher!.categoryId == null ||
                          state.data.voucher!.categoryId ==
                              widget.argument!.categoryId)
                        {
                          if (DateTime.now().isAfter(DateTime.tryParse(
                                  state.data.voucher!.startDate!)!) &&
                              DateTime.now().isBefore(DateTime.tryParse(
                                      state.data.voucher!.endDate!)!
                                  .add(const Duration(
                                      hours: 23, minutes: 59, seconds: 59))))
                            {
                              if (state.data.voucher!.maxQuota! >
                                  state.data.voucher!.totalUsed!)
                                {
                                  if (state.data.user!.isUsed! <
                                      state.data.voucher!.maxUsed!)
                                    {
                                      if (totalOrder >
                                          state.data.voucher!.minimumPurchase!)
                                        {
                                          isVoucherUsed = true,
                                          showToast('Berhasil digunakan.'),
                                          dataVoucher = state.data,
                                          updateCalculation()
                                        }
                                      else
                                        {
                                          showToastError(
                                              'Minimum pembelian ${rupiahFormatter(value: state.data.voucher!.minimumPurchase.toString())}')
                                        }
                                    }
                                  else
                                    {showToastError('Vocuher sudah digunakan!')}
                                }
                              else
                                {showToastError('Kuota Voucher Habis!')}
                            }
                          else
                            {
                              showToastError('Voucher telah kadaluarsa!'),
                              log(DateTime.now().toString()),
                              log(DateTime.tryParse(
                                      state.data.voucher!.endDate!)!
                                  .add(const Duration(
                                      hours: 23, minutes: 59, seconds: 59))
                                  .toString())
                            }
                        }
                      else
                        {
                          showToastError(
                              'Voucher tidak bisa digunakan di event ini!'),
                        }
                    }
                  else if (state is GetVoucherDetailNotFoundState)
                    {isLoadingVoucher = false, showToastError(state.message)}
                },
              ),
            )),
      ),
    );
  }

  Column _buildView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.size16, vertical: Dimens.size8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      LocaleKeys.event_order.tr(),
                      size: TextWidgetSize.h6,
                      weight: FontWeight.w600,
                      textColor: Pallete.primary,
                    ),
                    divide6,
                    ListView.builder(
                      itemCount: orderList!
                          .where((element) => element.ticket!.orderAmount! > 0)
                          .length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var ticket = orderList!
                            .where(
                                (element) => element.ticket!.orderAmount! > 0)
                            .toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimens.size10),
                          child: PackageTile(
                            orderAmount: ticket.ticket!.orderAmount ?? 0,
                            isCounterMode: false,
                            title: ticket.ticket!.title!,
                            price: ticket.ticket!.price!,
                            ticketStock: ticket.ticket!.stock,
                            finalPrice: (ticket.ticket!.orderAmount! *
                                    int.tryParse(ticket.ticket!.price!)!)
                                .toString(),
                            onTapPlus: () {
                              setState(() {
                                var indexTicket = orderList!.indexWhere(
                                    (element) =>
                                        element.ticket!.id ==
                                        ticket.ticket!.id);
                                orderList![indexTicket].ticket!.orderAmount =
                                    ticket.ticket!.orderAmount! + 1;
                              });
                              updateCalculation();
                            },
                            onTapMinus: () {
                              setState(() {
                                var indexTicket = orderList!.indexWhere(
                                    (element) =>
                                        element.ticket!.id ==
                                        ticket.ticket!.id);

                                if (ticket.ticket!.orderAmount != 1) {
                                  orderList![indexTicket].ticket!.orderAmount =
                                      ticket.ticket!.orderAmount! - 1;
                                  updateCalculation();
                                } else {
                                  openConfirmationDialog(
                                      indexTicket: indexTicket,
                                      ticketName: ticket.ticket!.title);
                                  // checkProduct();
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              divideThick(
                height: 10.0,
              ),
              divide8,
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.size16, vertical: Dimens.size8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      LocaleKeys.event_description.tr(),
                      size: TextWidgetSize.h6,
                      weight: FontWeight.w600,
                      textColor: Pallete.primary,
                    ),
                    divide10,
                    HtmlWidget(
                      widget.argument!.description ?? 'Tidak ada deskripsi',
                      textStyle: const TextStyle(
                          color: Pallete.greyDark,
                          fontSize: Dimens.size12,
                          fontWeight: FontWeight.w400),
                    )
                    // const ReadMoreText(
                    //   widget.argument!.description ?? '',
                    //   style: TextStyle(
                    //       color: Colors.grey, fontSize: Dimens.size12),
                    //   trimLines: 5,
                    //   colorClickableText: Colors.pink,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: 'Show more',
                    //   trimExpandedText: 'Show less',
                    //   lessStyle: TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.red),
                    //   moreStyle: TextStyle(
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.red),
                    // ),
                  ],
                ),
              ),
              divideThick(height: 10.0),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onSelectVa();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.size16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              LocaleKeys.core_payment_method.tr(),
                              size: TextWidgetSize.h7,
                              weight: FontWeight.w600,
                              textColor: Pallete.primary,
                            ),
                            TextWidget(
                                virtualAccount != null
                                    ? virtualAccount!.name
                                    : LocaleKeys.core_choose_method.tr(),
                                weight: FontWeight.w500,
                                textColor: Colors.grey,
                                size: TextWidgetSize.h7),
                          ],
                        ),
                        virtualAccount != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NetworkImagePlaceHolder(
                                    imageUrl: virtualAccount!.logo,
                                    fit: BoxFit.contain,
                                    width: 54,
                                    height: Dimens.size40,
                                  ),
                                  divideW10,
                                  const SvgUI('ic_account_right_arrow.svg')
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimens.size8,
                                    horizontal: Dimens.size32),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(1000)),
                                  color: Pallete.primary,
                                ),
                                child: TextWidget(
                                  LocaleKeys.core_select.tr(),
                                  size: TextWidgetSize.h7,
                                  weight: FontWeight.w600,
                                  textColor: Colors.white,
                                ),
                              ),

                        // RoundedButton(
                        //     text: LocaleKeys.core_select.tr(),
                        //     textSize: 12,
                        //     heigth: 30,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 4, vertical: 2),
                        //     press: () {
                        //       onSelectVa();
                        //     },
                        //     width: 100,
                        //   )
                      ],
                    ),
                  ),
                ),
              ),
              divideThick(height: 10.0),
              Container(
                padding: const EdgeInsets.all(Dimens.size16),
                child: Row(
                  children: [
                    Flexible(
                      child: EditTextField(
                          readOnly: isVoucherUsed,
                          controller: discountController,
                          hint: 'Kode Voucher',
                          hideLabel: true,
                          label: 'Voucher'),
                    ),
                    divideW10,
                    RoundedButton(
                      width: 100,
                      text: isVoucherUsed ? 'Batalkan' : 'Gunakan',

                      color: isVoucherUsed ? Colors.red : Pallete.primary,
                      isLoading: isLoadingVoucher,
                      press: () {
                        if (isVoucherUsed == true) {
                          setState(() {
                            discountController.clear();
                            isVoucherUsed = false;
                            dataVoucher = null;
                          });
                        } else {
                          eventBloc!.add(
                              GetVoucherDetailEvent(discountController.text));
                        }
                      },
                      // borderRadius: 8,
                    )
                  ],
                ),
              ),
              divideThick(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subtotalModel!
                          .where((element) => element.total! > 0)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        var subTotal = subtotalModel!
                            .where((element) => element.total! > 0)
                            .toList()[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: TextWidget(
                            subTotal.title,
                            size: TextWidgetSize.h6,
                            weight: FontWeight.w500,
                            textColor: Pallete.primary,
                            maxLines: 2,
                            ellipsed: true,
                          ),
                          trailing: TextWidget(
                            '${rupiahFormatter(value: subTotal.total.toString())}\n(x${subTotal.orderAmount})',
                            size: TextWidgetSize.h6,
                            textAlign: TextAlign.right,
                            weight: FontWeight.w500,
                            textColor: Pallete.primary,
                          ),
                        );
                        // return Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: Dimens.size4),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Flexible(
                        //         child: TextWidget(
                        //           subTotal.title,
                        //           size: TextWidgetSize.h6,
                        //           weight: FontWeight.w500,
                        //           textColor: Pallete.primary,
                        //           ellipsed: true,
                        //           maxLines: 2,
                        //         ),
                        //       ),
                        //       // divideW16,
                        //       Flexible(
                        //         fit: FlexFit.loose,
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             TextWidget(
                        //               rupiahFormatter(
                        //                   value: subTotal.total.toString()),
                        //               size: TextWidgetSize.h6,
                        //               weight: FontWeight.w500,
                        //               textColor: Pallete.primary,
                        //             ),
                        //             TextWidget(
                        //               '(x${subTotal.orderAmount})',
                        //               size: TextWidgetSize.h6,
                        //               weight: FontWeight.w500,
                        //               textColor: Pallete.primary,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ),
              DashDivider(
                color: Colors.grey.shade300,
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.size16),
                child: Column(
                  children: [
                    if (isVoucherUsed == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            'Potongan',
                            size: TextWidgetSize.h6,
                            textColor: Pallete.primary,
                            weight: FontWeight.w500,
                          ),
                          TextWidget(
                            '-${rupiahFormatter(value: discountOrder.toString())}',
                            size: TextWidgetSize.h6,
                            textColor: Pallete.primary,
                            weight: FontWeight.w500,
                          )
                        ],
                      ),
                    if (isVoucherUsed == true) divide10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'Total',
                          size: TextWidgetSize.h6,
                          weight: FontWeight.bold,
                          textColor: Pallete.primary,
                        ),
                        TextWidget(
                          rupiahFormatter(
                              value: isVoucherUsed
                                  ? (totalOrder - discountOrder).toString()
                                  : totalOrder.toString()),
                          size: TextWidgetSize.h6,
                          weight: FontWeight.bold,
                          textColor: Pallete.primary,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
        divideThick(),
        Container(
          padding: const EdgeInsets.all(Dimens.size16),
          child: RoundedButton(
            isLoading: isLoading,
            text: 'Order',
            press: virtualAccount != null
                ? () {
                    createOrder();
                  }
                : null,
            width: double.infinity,
          ),
        )
      ],
    );
  }

  checkProduct() {
    if (orderList!.isEmpty) {
      Navigator.pop(context, true);
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, true);
    return true;
  }

  void openConfirmationDialog({int? indexTicket, String? ticketName}) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          enableCancel: true,
          title: 'Hapus Tiket',
          descriptions:
              'Apakah anda ingin menghapus tiket $ticketName dari daftar order?',
          onCancelText: 'Batal',
          onOkText: 'Ya, hapus',
          onOkTap: () {
            Navigator.pop(context);
            setState(() {
              orderList!.removeAt(indexTicket!);
              checkProduct();
              updateCalculation();
            });
          },
        );
      },
    );
  }

  onSelectVa() async {
    var isUpdated = await Navigator.pushNamed(context, PaymentMethodScreen.path,
        arguments:
            PaymentMethodArgument(paymentMethod: widget.argument!.paymentMode));
    if (isUpdated != null) {
      setState(() {
        virtualAccount = isUpdated as VirtualAccount;
      });
    }
  }

  updateCalculation() {
    setState(() {
      // Clearing
      subtotalModel!.clear();
      totalOrder = 0;
      // adding
      for (var item in orderList!) {
        subtotalModel!.add(SubtotalModel(
            ticketId: item.ticket!.id,
            title: '${item.ticket!.title}',
            orderAmount: item.ticket!.orderAmount!,
            total: int.tryParse(item.ticket!.price!)! *
                item.ticket!.orderAmount!));

        var total = totalOrder +
            (int.tryParse(item.ticket!.price!)! * item.ticket!.orderAmount!);

        totalOrder = total;
      }

      if (isVoucherUsed == true) {
        if (dataVoucher!.voucher!.typeDiscount == 'PRICE') {
          discountOrder = dataVoucher!.voucher!.maxDiscount!;
        } else if (dataVoucher!.voucher!.typeDiscount == 'PERCENTAGE') {
          if ((totalOrder * dataVoucher!.voucher!.totalDiscount! ~/ 100) <
              dataVoucher!.voucher!.maxDiscount!) {
            discountOrder =
                (totalOrder * dataVoucher!.voucher!.totalDiscount! ~/ 100);
          } else {
            discountOrder = dataVoucher!.voucher!.maxDiscount!;
          }
        }
        log((totalOrder * (dataVoucher!.voucher!.totalDiscount! / 100))
            .toString());
        log((totalOrder * dataVoucher!.voucher!.totalDiscount! ~/ 100)
            .toString());
      }
    });
  }

  void createOrder() async {
    Map<String, dynamic> body = <String, dynamic>{};
    body['user_id'] = await LocalStorageService.getUserid();
    body['event_id'] = widget.argument!.eventId;
    body['total'] = totalOrder;
    body['is_paid'] = 0;
    body['status'] = 'NOT_PAID';
    // int sequence = 0;

    for (var i = 0; i < orderList!.length; i++) {
      var item = orderList![i];

      if (item.ticket!.orderAmount! > 0) {
        int totalPrice =
            int.tryParse(item.ticket!.price!)! * item.ticket!.orderAmount!;
        body['order_detail[$i][ticket_id]'] = item.ticket!.id;
        body['order_detail[$i][price]'] = item.ticket!.price;
        body['order_detail[$i][quantity]'] = item.ticket!.orderAmount;
        body['order_detail[$i][total_price]'] = totalPrice;
      }
    }
    body['bank_code'] = virtualAccount!.code;
    body['name'] = await LocalStorageService.getUserName();
    if (isVoucherUsed == true) {
      body['code'] = discountController.text;
    }
    log(body.toString());

    eventBloc!.add(CreateOrderEvent(body));
    // }
  }
}
