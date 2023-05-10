import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class PackageTile extends StatelessWidget {
  final String title;
  final String price;
  final String? finalPrice;
  final bool? isCounterMode;
  final int? orderAmount;
  final int? ticketStock;
  final Function()? onTapMinus;
  final Function()? onTapPlus;
  const PackageTile({
    Key? key,
    required this.title,
    required this.price,
    this.isCounterMode = false,
    this.orderAmount = 0,
    this.ticketStock,
    this.onTapMinus,
    this.onTapPlus,
    this.finalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 65,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Stack(children: [
        const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: SvgUI(
              'ic_package_accent.svg',
              height: 75,
            )),
        Container(
          padding: const EdgeInsets.all(Dimens.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextWidget(
                      title,
                      weight: FontWeight.w600,
                      ellipsed: true,
                      maxLines: 1,
                      size: TextWidgetSize.h6,
                    ),
                    divide4,
                    TextWidget(
                      rupiahFormatter(value: price),
                      textColor: Colors.red,
                      weight: FontWeight.w600,
                      size: TextWidgetSize.h6,
                    ),
                    divide4,
                    if (ticketStock != null)
                      TextWidget(
                        ticketStock! < 1
                            ? 'Habis'
                            : 'Tiket tersisa ($ticketStock)',
                        textColor: Colors.grey,
                        weight: FontWeight.w600,
                        size: TextWidgetSize.h8,
                      )
                  ],
                ),
              ),
              isCounterMode == false
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          rupiahFormatter(value: finalPrice!),
                          weight: FontWeight.w600,
                          size: TextWidgetSize.h6,
                        ),
                        divide4,
                        TextWidget(
                          '(x$orderAmount)',
                          weight: FontWeight.w600,
                          size: TextWidgetSize.h6,
                        ),
                      ],
                    )
                  // ? RoundedButton(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: Dimens.size10, vertical: Dimens.size4),
                  //     heigth: 28,
                  //     color: orderAmount != 0 ? Colors.red : Pallete.primary,
                  //     textSize: Dimens.size10,
                  //     text: ticketStock! < 1
                  //         ? 'Habis'
                  //         : orderAmount == 0
                  //             ? LocaleKeys.event_ticket_select.tr()
                  //             : LocaleKeys.event_ticket_selected.tr(),
                  //     press: ticketStock! < 1
                  //         ? null
                  //         : orderAmount != 0
                  //             ? onTapMinus
                  //             : onTapPlus)
                  : Container(
                      child: ticketStock! < 1
                          ? const RoundedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.size10,
                                  vertical: Dimens.size4),
                              heigth: 28,
                              textSize: Dimens.size10,
                              text: 'Habis',
                              press: null)
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // if (orderAmount! > 1)
                                InkWell(
                                  onTap: onTapMinus,
                                  child: const SvgUI(
                                    'ic_counter_minus.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                divideW10,
                                TextWidget(
                                    orderAmount == null
                                        ? '0'
                                        : orderAmount.toString(),
                                    size: TextWidgetSize.h6,
                                    weight: FontWeight.w600),
                                divideW10,
                                InkWell(
                                  onTap: onTapPlus,
                                  child: const SvgUI(
                                    'ic_counter_plus.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                )
                              ],
                            ),
                    )
            ],
          ),
        )
      ]),
    );
  }
}
