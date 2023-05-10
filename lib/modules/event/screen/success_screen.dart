import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/component/dash_divider.dart';
import 'package:shareticket/core/auth/component/dash_ticket.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/modules/event/bloc/event/event_bloc.dart';
import 'package:shareticket/modules/event/model/payment_status_result/payment_status_result.dart';
import 'package:shareticket/modules/home/model/event_result/event.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

import '../../../widget/screen/custom_scaffold.dart';

class SuccessArgument {
  final String? title;
  final String orderId;

  SuccessArgument({this.title, required this.orderId});
}

class SuccessScreen extends StatefulWidget {
  final SuccessArgument? argument;

  const SuccessScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/Success';
  static const String title = 'Success';

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String? title;
  bool? isSuccess = false;
  List<DetailWidget> listData = [];

  EventBloc? eventBloc;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = SuccessScreen.title;
    }

    eventBloc = EventBloc();
    eventBloc!.add(GetPaymentStatusEvent(widget.argument!.orderId));

    // listData = [
    //   const DetailWidget(
    //     title: 'TxID',
    //     content: '239238032490',
    //   ),
    //   const DetailWidget(
    //     title: 'Payment method',
    //     content: 'Mandiri',
    //   )
    // ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CustomScaffold(
          body: BlocProvider(
        create: (context) => eventBloc!,
        child: BlocConsumer<EventBloc, EventsState>(
          builder: (context, state) {
            if (state is GetPaymentStatusLoadingState) {
              return loading();
            } else if (state is GetPaymentStatusLoadedState) {
              return _buildView(context, state.data);
            } else if (state is GetPaymentStatusErrorState) {
              return TextWidget(state.message);
            }
            return Container();
          },
          listener: (context, state) => {
            if (state is GetPaymentStatusLoadedState)
              {
                setState(
                  () {
                    listData = [
                      DetailWidget(
                        title: 'TxID',
                        content: state.data.order!.code!,
                      ),
                    ];
                    isSuccess = state.data.order!.isPaid;
                  },
                )
              }
          },
        ),
      )),
    );
  }

  Widget _buildView(BuildContext context, PaymentStatusResult data) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(Dimens.size16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.size16),
                    topRight: Radius.circular(Dimens.size16))),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.size16),
                  child: Column(
                    children: [
                      SvgUI(isSuccess! ? 'ic_success.svg' : 'ic_pending.svg'),
                      divide20,
                      TextWidget(
                        isSuccess! ? 'Payment Success' : 'Payment Pending',
                        weight: FontWeight.bold,
                        size: TextWidgetSize.h3,
                        textColor: Pallete.primary,
                      ),
                      divide10,
                      TextWidget(
                        isSuccess!
                            ? 'Your payment for ${data.order!.event!.title} is success!'
                            : 'Your payment for  ${data.order!.event!.title} is pending!',
                        textAlign: TextAlign.center,
                        textColor: Colors.grey,
                        size: TextWidgetSize.h7,
                      ),
                      divide10,
                      TextWidget(
                        'Payment total',
                        weight: FontWeight.w600,
                        size: TextWidgetSize.h6,
                        textColor: Pallete.greyDark,
                      ),
                      divide10,
                      TextWidget(
                        rupiahFormatter(value: data.order!.total.toString()),
                        weight: FontWeight.bold,
                        size: TextWidgetSize.h3,
                        textColor: Pallete.primary,
                      ),
                      divide20,
                    ],
                  ),
                ),
                _dividerTicket(),
                ListView.separated(
                  padding: const EdgeInsets.all(Dimens.size10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var dataList = listData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size8, vertical: Dimens.size4),
                      child: DetailWidget(
                        title: dataList.title,
                        content: dataList.content,
                      ),
                    );
                  },
                  itemCount: listData.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return divideThick(height: 0.5);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimens.size16),
                  child: Column(
                    children: [
                      // DetailWidget(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     TextWidget(
                      //       'TX Id',
                      //       size: TextWidgetSize.h8,
                      //     ),
                      //     TextWidget(
                      //       '43028452308423423403249',
                      //       size: TextWidgetSize.h8,
                      //     ),
                      //   ],
                      // ),
                      // divideThick(),
                      divide28,
                      RoundedButton(
                        text: LocaleKeys.back_dashboard,
                        press: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, DashboardScreen.path, (route) => false,
                              arguments: DashboardArgument(currentTab: 0));
                        },
                        width: double.infinity,
                      ),

                      divide10,
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, DashboardScreen.path, (route) => false,
                              arguments: DashboardArgument(currentTab: 1));

                          // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                        },
                        child: TextWidget(
                          LocaleKeys.see_transaction.tr(),
                          weight: FontWeight.w600,
                          textColor: Colors.red,
                          size: TextWidgetSize.h6,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size8),
                  color: Colors.transparent,
                  child: Column(
                    children: const [
                      DashTicket(
                        color: Pallete.screenBackground,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _dividerTicket() {
    return Row(
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
        const Flexible(
          child: DashDivider(
            color: Color(0xFFF0F3F4),
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

  Future<bool> _onWillPop() async {
    Navigator.pushNamedAndRemoveUntil(
        context, DashboardScreen.path, (route) => false,
        arguments: DashboardArgument(currentTab: 1));
    return true;
  }
}

class DetailWidget extends StatelessWidget {
  final String? title;
  final String? content;
  const DetailWidget({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.size4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title,
            size: TextWidgetSize.h7,
            weight: FontWeight.w500,
            textColor: Pallete.primary,
          ),
          TextWidget(
            content,
            size: TextWidgetSize.h7,
            weight: FontWeight.w500,
            textColor: Pallete.primary,
          )
        ],
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
