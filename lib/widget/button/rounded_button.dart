import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? heigth;
  final double? borderRadius;
  final double? textSize;

  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color,
      this.padding,
      this.textColor,
      this.width,
      this.heigth,
      this.isLoading = false,
      this.borderRadius,
      this.borderColor,
      this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
      child: ElevatedButton(
          onPressed: !isLoading ? press ?? null : null,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(
                  padding ?? const EdgeInsets.all(Dimens.size16)),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Pallete.border;
                  } else if (states.contains(MaterialState.disabled)) {
                    return Pallete.secondary;
                  } else if (states.contains(MaterialState.focused)) {
                    return Pallete.primary;
                  }
                  return color ??
                      Pallete.primary; // Use the component's default.
                },
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: textColor ?? Pallete.dark1)),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) {
                return RoundedRectangleBorder(
                    side: !(states.contains(MaterialState.pressed))
                        ? BorderSide(color: borderColor ?? Colors.transparent)
                        : const BorderSide(color: Colors.transparent),
                    borderRadius:
                        BorderRadius.circular(borderRadius ?? Dimens.size128));
              })),
          child: isLoading
              ? loading(color: Pallete.dark1)
              : Text(
                  text,
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: textSize),
                ).tr()),
    );
  }
}
