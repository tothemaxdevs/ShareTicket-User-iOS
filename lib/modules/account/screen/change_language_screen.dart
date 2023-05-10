import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/splash/splash_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ChangeLanguageArgument {
  final String title;

  ChangeLanguageArgument(this.title);
}

class ChangeLanguageScreen extends StatefulWidget {
  final ChangeLanguageArgument? argument;

  const ChangeLanguageScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/account/language';
  static const String title = 'Change Language';

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String? title;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = ChangeLanguageScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(context: context, title: title, backButton: true),
        body: Padding(
          padding: const EdgeInsets.all(Dimens.size16),
          child: Column(
            children: [
              LanguangeCard(
                title: 'Indonesia',
                icon: 'ic_locale_id.svg',
                onTap: () async {
                  LocalStorageService.setLanguage('Indonesia');
                  context.setLocale(const Locale('id'));
                  Navigator.pushNamedAndRemoveUntil(
                      context, SplashScreen.path, (route) => false);
                },
              ),
              divide14,
              LanguangeCard(
                title: 'English',
                icon: 'ic_locale_en.svg',
                onTap: () async {
                  context.setLocale(const Locale('en'));
                  LocalStorageService.setLanguage('English');
                  Navigator.pushNamedAndRemoveUntil(
                      context, SplashScreen.path, (route) => false);
                },
              ),
              // ListTile(
              //     title: TextWidget(
              //       'Bahasa Indonesia',
              //     ),
              //     onTap: () async {
              //       context.setLocale(const Locale('id'));
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, SplashScreen.path, (route) => false);
              //     }),
              // divideThick(),
              // ListTile(
              //     title: TextWidget(
              //       'English',
              //     ),
              //     onTap: () async {
              //       context.setLocale(const Locale('en'));
              //       Navigator.pushNamedAndRemoveUntil(
              //           context, SplashScreen.path, (route) => false);
              //     }),
            ],
          ),
        ));
  }
}

class LanguangeCard extends StatelessWidget {
  final String title, icon;
  final Function() onTap;
  const LanguangeCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.size16)),
          color: Colors.white),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size16)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(Dimens.size16),
            child: Row(
              children: [
                SvgUI(
                  icon,
                  height: 34,
                  width: 34,
                ),
                divideW16,
                TextWidget(
                  title,
                  textColor: Pallete.primary,
                  weight: FontWeight.w500,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
