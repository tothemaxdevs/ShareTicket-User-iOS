import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/event/bloc/event/event_bloc.dart';
import 'package:shareticket/modules/event/model/va_list_result/va_list_result.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/modules/event/model/va_list_result/virtual_account.dart';

class PaymentMethodArgument {
  final String? title;
  List<String> paymentMethod;

  PaymentMethodArgument({this.title, required this.paymentMethod});
}

class PaymentMethodScreen extends StatefulWidget {
  final PaymentMethodArgument? argument;

  const PaymentMethodScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/PaymentMethod';
  static const String title = 'Payment Method';

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? title;
  EventBloc? eventBloc;
  Map<String, dynamic> params = {};
  @override
  void initState() {
    if (widget.argument!.title != null) {
      title = widget.argument?.title;
    } else {
      title = PaymentMethodScreen.title;
    }

    for (var element in widget.argument!.paymentMethod) {
      params[element] = true;
    }

    log('ini params ${params.toString()}');

    eventBloc = EventBloc();
    eventBloc!.add(GetVaEvent(params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.screenBackground,
        appBar: appBar(
            context: context,
            backButton: true,
            title: LocaleKeys.core_payment_method.tr()),
        body: BlocProvider(
          create: (context) => eventBloc!,
          child: BlocConsumer<EventBloc, EventsState>(
            builder: (context, state) {
              if (state is GetPaymentMethodLoadingState) {
                return _buildLoading();
              } else if (state is GetPaymentMethodLoadedState) {
                return _buildView(state.data);
              } else if (state is GetPaymentMethodErrorState) {
                return TextWidget(state.message);
              } else if (state is GetPaymentMethodEmptyState) {
                return IllustrationWidget(
                  type: IllustrationWidgetType.notFound,
                  showButton: true,
                  onButtonTap: () {
                    Navigator.pop(context);
                  },
                );
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ));
  }

  Widget _buildView(VaListResult data) {
    return RefreshIndicator(
      onRefresh: () async {
        eventBloc!.add(GetVaEvent(params));
      },
      child: ListView(
        padding: const EdgeInsets.all(Dimens.size16),
        children: [
          if (data.payment!.virtualAccount != null)
            VaMethod(
              title: 'Virtual Account',
              data: data.payment!.virtualAccount,
            ),
          if (data.payment!.qris != null)
            VaMethod(title: 'Qris', data: data.payment!.qris),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.size16, horizontal: Dimens.size16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Blink(
                        width: Dimens.size48,
                        height: Dimens.size40,
                      ),
                      divideW20,
                      const Blink(
                        width: 150,
                        height: Dimens.size16,
                      ),
                    ],
                  ),
                  const SvgUI('ic_account_right_arrow.svg')
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return divideThick();
      },
    );
  }
}

class VaMethod extends StatelessWidget {
  final String? title;
  final List<VirtualAccount>? data;

  const VaMethod({
    Key? key,
    this.title,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
            child: TextWidget(
              title,
              weight: FontWeight.w600,
              textColor: Colors.grey,
            )),
        divide10,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            var virtualAccount = data![index];
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.size8)),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Dimens.size8)),
                  onTap: () {
                    if (virtualAccount.isActivated == true) {
                      if (virtualAccount.statusPayment == 'ACTIVE') {
                        showDialogConfirmation(virtualAccount, context);
                      } else {
                        Navigator.pop(context, virtualAccount);
                      }
                    } else {
                      maintenanceDialog(virtualAccount, context);
                    }
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.size16, horizontal: Dimens.size16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                NetworkImagePlaceHolder(
                                  imageUrl: virtualAccount.logo,
                                  fit: BoxFit.contain,
                                  width: Dimens.size48,
                                  height: Dimens.size40,
                                ),
                                divideW20,
                                TextWidget(
                                  virtualAccount.name,
                                  size: TextWidgetSize.h6,
                                  textColor: Pallete.textPrimary,
                                ),
                              ],
                            ),
                            const SvgUI('ic_account_right_arrow.svg')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return divideThick();
          },
        ),
      ],
    );
  }

  void showDialogConfirmation(
      VirtualAccount virtualAccount, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          title: 'Pemberitahuan',
          descriptions:
              'Anda masih memiliki pembayaran melalui ${virtualAccount.name} yang belum selesai, apabila melanjutkan pesanan ini pesanan sebelumnya akan dibatalkan.',
          onOkText: 'Lanjutkan',
          enableCancel: true,
          onCancelText: 'Batal',
          onOkTap: () {
            Navigator.pop(context, virtualAccount);
            Navigator.pop(context, virtualAccount);
          },
        );
      },
    );
  }

  void maintenanceDialog(VirtualAccount virtualAccount, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          title: 'Pemberitahuan',
          descriptions:
              'Pembayaran melalui ${virtualAccount.name} (${virtualAccount.code}) sedang maintenance, silahkan pilih metode pembayaran lain.',
          onOkText: 'Tutup',
          enableCancel: false,
          onCancelText: 'Batal',
          onOkTap: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
