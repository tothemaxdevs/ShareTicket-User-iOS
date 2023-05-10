import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';

class DotCircle extends StatelessWidget {
  double? size;
  DotCircle({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? Dimens.size6,
      height: size ?? Dimens.size6,
      decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: const BorderRadius.all(Radius.circular(1000))),
    );
  }
}
