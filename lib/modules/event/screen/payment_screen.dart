import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/event/bloc/event/event_bloc.dart';
import 'package:shareticket/modules/event/component/custom_button.dart';
import 'package:shareticket/modules/event/component/guide_accordion.dart';
import 'package:shareticket/modules/event/model/payment_result/payment_result.dart';
import 'package:shareticket/modules/event/screen/expired_screen.dart';
import 'package:shareticket/modules/event/screen/success_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

import 'package:shareticket/widget/text/text_widget.dart';

class PaymentArgument {
  final String? title;
  final String orderId;
  final String bankCode;

  PaymentArgument({this.title, required this.orderId, required this.bankCode});
}

class PaymentScreen extends StatefulWidget {
  final PaymentArgument? argument;

  const PaymentScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/Payment';
  static const String title = 'Payment';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? title;
  String? pageView = 'loading';
  EventBloc? eventBloc;
  bool? isLoading = false;
  final Map<String, dynamic> _params = {};
  DateTime dateTimeNows = DateTime.tryParse(
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))!;
  ScreenshotController screenshotController = ScreenshotController();
  bool isCopied = false;
  PaymentResult dataResult = PaymentResult();

  String userName = 'Loading...';

  Timer? _timer;
  @override
  void initState() {
    if (widget.argument!.title != null) {
      title = widget.argument?.title;
    } else {
      title = PaymentScreen.title;
    }

    loadUserName();

    _params['order_id'] = widget.argument!.orderId;
    _params['bank_code'] = widget.argument!.bankCode;
    eventBloc = EventBloc();
    eventBloc!.add(GetPaymentEvent(_params));
    log('--------------------------');
    log('Order id : ${widget.argument!.orderId}');
    log('Bank code : ${widget.argument!.bankCode}');

    log('--------------------------');
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // cancel the timer when the screen is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.screenBackground,
        appBar: appBar(
          context: context,
          backButton: false,
          title: PaymentScreen.title,
        ),
        body:
            // _builderView());

            BlocProvider(
          create: (context) => eventBloc!,
          child: BlocConsumer<EventBloc, EventsState>(
            builder: (context, state) {
              return statePageView(pageView);
            },
            listener: (context, state) => {
              if (state is GetPaymentLoadingState)
                {
                  pageView = 'loading',
                }
              else if (state is GetFailedLoadedState)
                {
                  pageView = 'error',
                }
              else if (state is GetPaymentLoadedState)
                {
                  setState(() {
                    dataResult = state.data;
                  }),
                  if (state.data.payementGuide!.bankCode == 'QRIS')
                    {pageView = 'loaded'}
                  else
                    {
                      eventBloc!
                          .add(PostUpdateStatusEvent(widget.argument!.orderId)),
                      if (dateTimeNows.isAfter(DateTime.tryParse(DateFormat(
                              'yyyy-MM-dd HH:mm:ss')
                          .format(DateTime.tryParse(
                              state.data.virtualAccount!.expirationDate!)!))!))
                        {routeExpire(), showToastError('Expire.')}
                      else
                        {
                          pageView = 'loaded',
                          realtimeCheck(DateTime.tryParse(
                              DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                  DateTime.tryParse(state
                                      .data.virtualAccount!.expirationDate!)!)))
                        }
                    }
                }
              else if (state is GetPaymentErrorState)
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
            },
          ),
        ));
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
          refreshBloc();
        },
      );
    }
  }

  Widget _buildView(PaymentResult data) {
    return Column(
      children: [
        Expanded(
            child: ListView(
                padding: const EdgeInsets.all(Dimens.size16),
                children: [
              paymentViewMode(data),
              // cardPayment(data),
              divide16,
              const Text(
                'Cara pembayaran',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Pallete.primary,
                    fontSize: Dimens.size12),
              ),
              const Divider(),
              GuideAccordion(
                title: widget.argument!.bankCode == 'QRIS'
                    ? 'Scan dari device lain'
                    : 'ATM',
                guide: data.payementGuide!.paymentAtm!,
              ),
              const Divider(),
              GuideAccordion(
                title: widget.argument!.bankCode == 'QRIS'
                    ? 'Simpan QR'
                    : 'Mobile Banking',
                guide: data.payementGuide!.paymentMbanking!,
              ),
              const Divider(),
              GuideAccordion(
                title: widget.argument!.bankCode == 'QRIS'
                    ? 'Buka QR'
                    : 'Internet Banking',
                guide: data.payementGuide!.paymentIbanking!,
              ),
              const Divider(),
            ])),
        divideThick(),
        Container(
          padding: const EdgeInsets.all(Dimens.size16),
          child: RoundedButton(
            width: double.infinity,
            isLoading: isLoading!,
            text: LocaleKeys.payment_have_paid.tr(),
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, SuccessScreen.path, (route) => false,
                  arguments:
                      SuccessArgument(orderId: widget.argument!.orderId));
            },
          ),
        )
      ],
    );
  }

  Widget cardPayment(PaymentResult data) {
    return Column(
      children: [
        Column(
          children: [
            TextWidget(
              'Bayar sebelum',
              textColor: Colors.grey,
              weight: FontWeight.w600,
            ),
            divide6,
            // TextWidget(data.account!.expirationDate.toString()),
            // TextWidget(DateFormat('dd MMMM yyyy, HH:mm:ss')
            //     .format(DateTime.parse('2023-03-03 18:14:48')))
            TextWidget(
              DateFormat(data.virtualAccount!.expirationDate).format(
                  DateTime.tryParse(data.virtualAccount!.expirationDate!)!),
              size: TextWidgetSize.h4,
              weight: FontWeight.w600,
              textColor: Colors.red,
            ),
          ],
        ),
        divide16,
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
          child: Stack(
            children: [
              const SvgUI(
                'payment_accent.svg',
                height: 165,
              ),
              Container(
                  height: 165,
                  padding: const EdgeInsets.all(Dimens.size14),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),

                      // boxShadow: kElevationToShadow[0.5],

                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimens.size16))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NetworkImagePlaceHolder(
                              imageUrl: data.payementGuide!.icon,
                              fit: BoxFit.contain,
                              width: 90,
                              height: 40,
                            ),
                            divideW14,
                            Flexible(
                              child: TextWidget(
                                  'a.n. ${data.virtualAccount!.accountName}',
                                  fontSize: Dimens.size14,
                                  weight: FontWeight.w500,
                                  maxLines: 1,
                                  ellipsed: true),
                            ),
                          ],
                        ),
                        divide12,
                        const Text(
                          'Virtual account',
                          style: TextStyle(
                              fontSize: Dimens.size12,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              data.virtualAccount!.accountNumber!,
                              style: const TextStyle(
                                  fontSize: Dimens.size20,
                                  fontWeight: FontWeight.w600),
                            ),
                            divideW8,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isCopied = true;
                                });
                                _copyVirtualAccount(
                                    virtualAccount:
                                        data.virtualAccount!.accountNumber!);
                              },
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimens.size64)),
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.size12),
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: isCopied
                                        ? Colors.green
                                        : Pallete.screenBackground,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(Dimens.size64)),
                                    border: Border.all(
                                        color: isCopied
                                            ? Colors.green
                                            : Pallete.border,
                                        width: Dimens.size1),
                                    // color: Colors.grey,
                                  ),
                                  child: TextWidget(
                                    isCopied ? 'Disalin' : 'Salin',
                                    size: TextWidgetSize.h8,
                                    weight: FontWeight.w600,
                                    textColor:
                                        isCopied ? Colors.white : Colors.black,
                                  )),
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total pembayaran',
                              style: TextStyle(
                                  fontSize: Dimens.size12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              rupiahFormatter(
                                  value:
                                      '${data.virtualAccount!.expectedAmount}'),
                              style: const TextStyle(
                                  fontSize: Dimens.size14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ])),
            ],
          ),
        ),
      ],
    );
  }

  void _copyVirtualAccount({required String virtualAccount}) {
    Clipboard.setData(ClipboardData(text: virtualAccount)).then((_) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          isCopied = false;
        });
      });
    });
  }

  void refreshBloc() {
    _params['order_id'] = widget.argument!.orderId;

    eventBloc!.add(GetPaymentEvent(_params));
  }

  realtimeCheck(DateTime? specifiedTime) {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      DateTime dateTimeNow = DateTime.tryParse(
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()))!;
      log('onChec');
      if (dateTimeNow.isAfter(specifiedTime!)) {
        // Run your command here
        routeExpire();
      }
    });
  }

  routeExpire() {
    Navigator.pushNamedAndRemoveUntil(
        context, ExpiredScreen.path, (route) => false,
        arguments: ExpiredArgument(orderId: widget.argument!.orderId));
  }

  Widget paymentViewMode(PaymentResult data) {
    if (data.payementGuide!.bankCode == 'QRIS') {
      return qrPaymentView(data);
    } else {
      return cardPayment(data);
    }
  }

  Widget qrPaymentView(PaymentResult data) {
    return Column(
      children: [
        qrSection(data),
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Row(
            children: [
              Flexible(
                  child: CustomButton(
                title: 'Simpan QR',
                icon: Icons.save_alt_rounded,
                onTap: () {
                  saveShareMethod(data, isSave: true);
                },
              )),
              divideW10,
              Flexible(
                  child: CustomButton(
                title: 'Buka QR',
                icon: Icons.share,
                onTap: () {
                  saveShareMethod(data, isSave: false);
                },
              )),
            ],
          ),
        ),
      ],
    );
  }

  Container qrSection(PaymentResult data) {
    return Container(
      color: Pallete.screenBackground,
      padding: const EdgeInsets.symmetric(vertical: Dimens.size8),
      child: Column(
        children: [
          const SvgUI(
            'ic_qris_logo.svg',
            width: 100,
          ),
          divide16,
          TextWidget('a.n. $userName',
              fontSize: Dimens.size16,
              weight: FontWeight.w500,
              maxLines: 1,
              ellipsed: true),
          divide4,
          Text(
            rupiahFormatter(value: '${data.qris!.amount}'),
            style: const TextStyle(
                fontSize: Dimens.size16,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
          divide16,
          BarcodeWidget(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            barcode: Barcode.qrCode(),
            // Barcode type and settings
            data: data.qris!.qrString!,
            height: MediaQuery.of(context).size.width * 0.65,
            // width: double.infinity,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.size12,
                color: Colors.white),
          ),
          divide10,
        ],
      ),
    );
  }

  void saveShareMethod(PaymentResult data, {required bool isSave}) {
    var container = Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          divide10,
          qrSection(data),
          Container(
            color: Pallete.primary,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size32, vertical: Dimens.size16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SvgUI(
                  'ic_logo_2.svg',
                  color: Colors.white,
                  height: 26,
                ),
                divideW10,
                Column(
                  children: [
                    TextWidget(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                      textColor: Colors.white.withAlpha(100),
                      weight: FontWeight.w600,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    if (!isSave) {
      showToast('Mohon menunggu.');
    }

    screenshotController
        .captureFromWidget(
            InheritedTheme.captureAll(context, Material(child: container)),
            delay: const Duration(seconds: 1))
        .then((capturedImage) async {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(capturedImage);

      if (isSave) {
        final result = await ImageGallerySaver.saveImage(capturedImage,
            quality: 100,
            name:
                'Pembayaran STicket ${DateFormat('yyyy-MM-dd hh-mm-ss').format(DateTime.now())}');
        log(result.toString());
        RegExp regExp = RegExp(r"isSuccess:\s*(\w+)");
        bool isSuccess =
            regExp.firstMatch(result.toString())?.group(1)?.toLowerCase() ==
                'true';

        if (isSuccess) {
          showToast('QR Berhasil tersimpan di galeri.');
        } else {
          showToastError('Gagal menyimpan QR.');
          // log(errorMessage!);
        }
      } else {
        await Share.shareXFiles([XFile(imagePath.path)]);
      }
    });
    screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {})
        .catchError((onError) {
      log(onError);
    });
  }

  Future<void> loadUserName() async {
    String name = await LocalStorageService.getUserName();

    setState(() {
      userName = name;
    });
  }
}
