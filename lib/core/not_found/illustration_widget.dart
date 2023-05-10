import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

enum IllustrationWidgetType { notFound, success, error, empty }

class IllustrationWidget extends StatelessWidget {
  String? illustration;
  String? title;
  String? description;
  String? textButton;
  Function()? onButtonTap;
  IllustrationWidgetType? type;
  bool? showButton;
  IllustrationWidget(
      {Key? key,
      this.illustration,
      this.title,
      this.description,
      this.textButton,
      this.type,
      this.onButtonTap,
      this.showButton = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IllustrationWidgetType.notFound:
        illustration = 'ic_illustration_notfound.svg';
        description = 'The page that you enter is not found!';
        title = 'Page not found!';
        showButton = true;
        onButtonTap = () {
          Navigator.pop(context);
        };
        textButton = 'Back to previous screen';
        break;
      case IllustrationWidgetType.success:
        illustration = 'ic_illustration_success.svg';
        description = 'Your registration is success!';
        title = 'Success';
        showButton = true;
        onButtonTap = () {
          Navigator.pop(context);
        };
        textButton = 'Back to login';
        break;

      case IllustrationWidgetType.error:
        illustration = 'ic_illustration_error.svg';
        description = 'Error to connect to server!';
        title = 'Error';
        showButton = true;
        onButtonTap = onButtonTap;
        textButton = 'Try again';
        break;
      case IllustrationWidgetType.empty:
        illustration = 'ic_illustration_empty.svg';
        description = 'Data that you looking is empty!';
        title = 'Empty';
        showButton = false;
        onButtonTap = onButtonTap;
        textButton = 'Try again';
        break;
      default:
    }
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgUI(
            'illustration/$illustration',
            width: 300,
            height: 300,
          ),
          TextWidget(
            '$title',
            size: TextWidgetSize.h3,
            weight: FontWeight.w600,
          ),
          if (description != '') divide10,
          if (description != '')
            TextWidget(
              '$description',
              textAlign: TextAlign.center,
              size: TextWidgetSize.h6,
              weight: FontWeight.w400,
              textColor: Pallete.greyDark,
            ),
          if (showButton!) divide32,
          if (showButton!)
            RoundedButton(text: '$textButton', press: onButtonTap)
        ],
      ),
    ));
  }
}
