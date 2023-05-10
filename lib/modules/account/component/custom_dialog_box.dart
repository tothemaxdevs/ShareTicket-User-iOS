import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class DialogBox extends StatefulWidget {
  final String? title, descriptions, onOkText, onCancelText;
  final bool enableCancel;
  final bool isOkPrimary;
  final Function()? onOkTap, onCancelTap;
  final Color? okBakcgroundColor;
  final Widget? child;
  const DialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.onOkText,
      this.onOkTap,
      this.onCancelText,
      this.onCancelTap,
      this.child,
      this.enableCancel = false,
      this.isOkPrimary = false,
      this.okBakcgroundColor})
      : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.size16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(Dimens.size20),
          // ),
          // margin: EdgeInsets.only(top: ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimens.size16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextWidget(
                widget.title!,
                fontSize: 18,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              divide8,
              widget.child ??
                  TextWidget(
                    widget.descriptions!,
                    fontSize: 14,
                    weight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
              divide14,
              RoundedButton(
                width: double.infinity,
                text: widget.onOkText != null
                    ? '${widget.onOkText}'
                    : LocaleKeys.core_ok,
                press: widget.onOkTap ??
                    () {
                      Navigator.pop(context);
                    },
                borderColor: widget.okBakcgroundColor ?? Pallete.primary,
                color: widget.enableCancel
                    ? widget.okBakcgroundColor ?? Pallete.primary
                    : widget.isOkPrimary
                        ? widget.okBakcgroundColor ?? Pallete.primary
                        : Colors.white,
                textColor: widget.enableCancel
                    ? Colors.white
                    : widget.isOkPrimary
                        ? Colors.white
                        : Pallete.primary,
              ),
              if (widget.enableCancel) divide10,
              if (widget.enableCancel)
                RoundedButton(
                  width: double.infinity,
                  text: widget.onCancelText != null
                      ? '${widget.onCancelText}'
                      : LocaleKeys.core_cancel,
                  press: widget.onCancelTap ??
                      () {
                        Navigator.pop(context);
                      },
                  borderColor: Colors.white,
                  color: Colors.white,
                  textColor: Colors.black,
                )
            ],
          ),
        ),
      ],
    );
  }
}
