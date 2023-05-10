import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class TextFieldDialogBox extends StatefulWidget {
  final String? title, descriptions, hint, onCancelText, onOkText;
  final Image? img;
  final TextEditingController controller;
  final GlobalKey<FormState>? formKey;
  final Function()? onCancelTap, onOkTap;

  const TextFieldDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.hint,
      this.img,
      this.onCancelText,
      this.onOkText,
      this.onCancelTap,
      this.onOkTap,
      this.formKey,
      required this.controller})
      : super(key: key);

  @override
  _TextFieldDialogBoxState createState() => _TextFieldDialogBoxState();
}

class _TextFieldDialogBoxState extends State<TextFieldDialogBox> {
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
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.size14, horizontal: Dimens.size16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.size16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          divide10,
          TextWidget(
            widget.title!,
            fontSize: 18,
            weight: FontWeight.bold,
          ),
          if (widget.descriptions != null) divide8,
          if (widget.descriptions != null)
            Text(
              widget.descriptions!,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          EditTextField(
            controller: widget.controller,
            hint: widget.hint,
            validator: requiredValidator,
            label: '',
          ),
          divide20,
          Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: RoundedButton(
                    text: widget.onCancelText!.isNotEmpty
                        ? '${widget.onCancelText}'
                        : LocaleKeys.core_cancel,
                    press: widget.onCancelTap ??
                        () {
                          Navigator.pop(context);
                        },
                    color: Colors.white,
                    textColor: Pallete.primary,
                    borderColor: Pallete.primary,
                  )),
              divideW10,
              Flexible(
                  fit: FlexFit.tight,
                  child: RoundedButton(
                    text: widget.onCancelText!.isNotEmpty
                        ? '${widget.onOkText}'
                        : LocaleKeys.core_ok,
                    press: widget.onOkTap ??
                        () {
                          Navigator.pop(context);
                        },
                    borderColor: Pallete.primary,
                    textColor: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
