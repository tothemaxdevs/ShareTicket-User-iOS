import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';

class Or extends StatelessWidget {
  const Or({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            height: 1,
            color: Colors.grey.withAlpha(30),
          ),
        ),
        divideW10,
        const Text(LocaleKeys.core_or).tr(),
        divideW10,
        Flexible(
          child: Container(
            height: 1,
            color: Colors.grey.withAlpha(30),
          ),
        ),
      ],
    );
  }
}
