import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/config/size/size.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';

class SearchBar extends StatelessWidget {
  String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color? backgroundColor;
  SearchBar({
    Key? key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initSizeConfig(context);

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.size10),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Container(
        width: double.infinity,
        height: 37,
        decoration: BoxDecoration(
          color: backgroundColor ?? Pallete.textField,
          borderRadius: BorderRadius.circular(Dimens.size8),
        ),
        child: TextField(
          controller: controller,
          autofocus: false,
          style: const TextStyle(
            fontSize: Dimens.size16,
            fontStyle: FontStyle.normal,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              // vertical: 6,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: ('$hintText').tr(),
            hintStyle: const TextStyle(
              color: Pallete.textPlaceholder,
              fontSize: Dimens.size12,
            ),
            prefixIcon: const Icon(
              Iconly.search,
              color: Colors.black,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }
}
