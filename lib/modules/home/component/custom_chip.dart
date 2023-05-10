import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';

class ChipCustom extends StatelessWidget {
  String? text;
  ChipCustom({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.size10, vertical: Dimens.size4),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size112))),
      child: Text(
        '$text',
        style: const TextStyle(fontSize: Dimens.size10),
      ),
    );
  }
}
