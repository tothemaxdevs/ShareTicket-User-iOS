import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shimmer/shimmer.dart';

class Blink extends StatelessWidget {
  final bool isCircle;
  final double? borderRadius;
  final double height;
  final double width;

  const Blink(
      {Key? key,
      required this.height,
      required this.width,
      this.isCircle = false,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(
                isCircle ? 300 : borderRadius ?? Dimens.size16))),
        height: height,
        width: width,
      ),
    );
  }
}
