import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

class EditTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final FormFieldValidator<String>? validator;
  final int? maxlines;
  final bool readOnly;
  final bool isNumber;
  final bool isPasswordMode;
  final bool isMarginTop;
  final bool isMarginBottom;
  final int? limit;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Function(String? value)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool hideLabel;

  EditTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.label,
      this.validator,
      this.textInputAction,
      this.onChanged,
      this.maxlines,
      this.readOnly = false,
      this.isNumber = false,
      this.onTap,
      this.limit,
      this.prefixIcon,
      this.suffixIcon,
      this.isPasswordMode = false,
      this.isMarginTop = false,
      this.isMarginBottom = false,
      this.autofocus = false,
      this.hideLabel = false})
      : super(key: key);
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  late bool showPassword;
  @override
  void initState() {
    showPassword = widget.isPasswordMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isMarginTop == true) divide16,
        if (widget.hideLabel == false)
          Text(
            '${widget.label}',
            style: const TextStyle(
                fontSize: Dimens.size12,
                fontWeight: FontWeight.w600,
                color: Pallete.primary),
          ).tr(),
        if (widget.hideLabel == false) divide4,
        TextFormField(
          autofocus: widget.autofocus,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: showPassword,
          maxLines: widget.maxlines ?? 1,
          textInputAction: widget.textInputAction,
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
              fontSize: Dimens.size14, height: 1.0, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            suffixIcon: widget.suffixIcon ??
                (widget.isPasswordMode == true
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: SvgUI(
                            showPassword
                                ? 'ic_password_hide.svg'
                                : 'ic_password_show.svg',
                            // color: showPassword ? Colors.grey : Pallete.primary,
                          ),
                        ))
                    : null),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.prefixIcon,
                  )
                : null,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Pallete.border, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.size16))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Pallete.border, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(Dimens.size16))),
            hintText: (widget.hint!).tr(),
            // hintText: (widget.hint!).tr() ?? widget.label,
            // labelText: label,
            // labelStyle: TextStyle(fontSize: Dimens.size12)
          ),
          validator: widget.validator,
          inputFormatters: [
            if (widget.limit != null)
              LengthLimitingTextInputFormatter(widget.limit),
          ],
        ),
        if (widget.isMarginBottom == true) divide16,
      ],
    );
  }
}
