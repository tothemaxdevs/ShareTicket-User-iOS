import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class ForgotPasswordSentArgument {
  final String email;

  ForgotPasswordSentArgument(this.email);
}

class ForgotPasswordSentScreen extends StatefulWidget {
  final ForgotPasswordSentArgument? argument;

  const ForgotPasswordSentScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/forgotpasswordSent';
  static const String title = 'Forgot Password';

  @override
  _ForgotPasswordSentScreenState createState() =>
      _ForgotPasswordSentScreenState();
}

class _ForgotPasswordSentScreenState extends State<ForgotPasswordSentScreen> {
  String? title;

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Pallete.screenBackground,
          appBar: appBar(context: context, backButton: true, title: ''),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgUI(
                'ic_forgot_password_send.svg',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              divide16,
              TextWidget(
                'Cek email kamu',
                size: TextWidgetSize.h3,
                textColor: Pallete.primary,
                weight: FontWeight.bold,
              ),
              divide8,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: TextWidget(
                  'Kami telah mengim link pemulihan ke email ${widget.argument!.email}, cek spam apabila tidak ada di kotak masuk.',
                  size: TextWidgetSize.h6,
                  textAlign: TextAlign.center,
                  textColor: Pallete.greyDark,
                ),
              ),
              divide40,
              RoundedButton(
                  width: MediaQuery.of(context).size.width * 0.5,
                  text: 'Buka email',
                  // width: double.infinity,
                  press: () async {
                    // Android: Will open mail app or show native picker.
                    // iOS: Will open mail app if single mail app found.
                    var result = await OpenMailApp.openMailApp();

                    // If no mail apps found, show error
                    if (!result.didOpen && !result.canOpen) {
                      showNoMailAppsDialog(context);

                      // iOS: if multiple mail apps found, show dialog to select.
                      // There is no native intent/default app system in iOS so
                      // you have to do it yourself.
                    } else if (!result.didOpen && result.canOpen) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(
                            mailApps: result.options,
                          );
                        },
                      );
                    }
                  }),
              divide16,
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TextWidget(
                    'Kembali ke halaman login',
                    weight: FontWeight.w600,
                    size: TextWidgetSize.h6,
                    textColor: Pallete.primary,
                  ))
            ],
          )),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const DialogBox(
          title: 'Buka email',
          descriptions: 'Tidak ada aplikasi email terinstall',
          onOkText: 'Tutup',
        );
      },
    );
  }
}
