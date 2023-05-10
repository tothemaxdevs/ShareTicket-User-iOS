// import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Widget loading({color, bool foldingCube = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      foldingCube
          ? SpinKitFadingCube(
              color: color ?? Pallete.primary,
              size: 20,
            )
          : SpinKitThreeBounce(
              color: color ?? Pallete.primary,
              size: 20,
            ),
    ],
  );
}

String rupiahFormatter({
  required String value,
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(int.parse(value.toString()));
}

AppBar appBar(
    {required BuildContext context,
    String? title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
    Color? color,
    bool? backButton = false,
    bool? isSearch = false,
    String? hintSearchText,
    TextEditingController? textEditSearchController,
    final SystemUiOverlayStyle? systemOverlayStyle,
    Function(String)? onSubmitted,
    // PreferredSizeWidget? bottom,
    Function(String)? onChanged,
    Function()? onBackTap,
    bool? centerTitle}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    bottom: isSearch == true
        ? PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: SearchBar(
                controller: textEditSearchController,
                onChanged: onChanged,
                hintText: '$hintSearchText'))
        : null,
    elevation: 0,
    systemOverlayStyle: systemOverlayStyle ??
        const SystemUiOverlayStyle(
          statusBarColor: Pallete.screenBackground,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
    title: subtitle != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Text(
                  title,
                  style: const TextStyle(
                      color: Pallete.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontSize: Dimens.size14),
                ).tr(),
              Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: Dimens.size10),
              ).tr()
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(left: Dimens.size16),
            child: Text(
              '$title',
              style: const TextStyle(
                  color: Pallete.dark1,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2.0,
                  fontSize: Dimens.size16),
            ).tr(),
          ),
    leading: backButton == true
        ? IconButton(
            onPressed: onBackTap ??
                () {
                  Navigator.of(context).pop();
                },
            icon: const SvgUI(
              'ic_appbar_back.svg',
              width: 30,
              height: 30,
            ))
        : leading ?? null,
    // centerTitle: true,
    titleSpacing: 0,
    actions: actions,
    backgroundColor: color ?? Pallete.screenBackground,
  );
}

Widget divideThick({height, color, margin}) {
  return Container(
    height: height ?? Dimens.size2,
    color: color ?? Pallete.line,
    margin: margin ?? EdgeInsets.zero,
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

BoxDecoration roundedDecoration({color, borderColor, radius}) {
  return BoxDecoration(
      color: color ?? Colors.white,
      border:
          Border.all(color: borderColor ?? Colors.white, width: Dimens.size1),
      borderRadius: radius ??
          const BorderRadius.all(
            Radius.circular(Dimens.size16),
          ));
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      fontSize: 16.0);
}

void showToastError(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      fontSize: 16.0);
}

// -----------------------------------//
//-------------VALIDATOR--------------//

String? Function(String?) requiredValidator = (String? value) {
  if (value!.isEmpty) {
    return 'Tidak boleh kosong';
  }
};

String? Function(String?) requiredPassword = (String? value) {
  if (value!.isEmpty) {
    return 'Tidak boleh kosong';
  } else if (value.length < 8) {
    return 'Minimal 8 karakter';
  }
};

String? Function(String?) requiredEmail = (String? value) {
  if (value!.isEmpty) {
    return 'Tidak boleh kosong';
  }

  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (!emailValid) {
    return 'Format email tidak sesusai';
  }
};

String? Function(String?) validateLetterOnly = (String? value) {
  String patttern = r"^[a-zA-Z_ ]*$";
  RegExp regExp = new RegExp(patttern);
  if (value!.isEmpty) {
    return 'Tidak boleh kosong';
  } else if (!regExp.hasMatch(value)) {
    return 'Hanya boleh menggunakan abjad';
  }
  return null;
};

String? Function(String?) validateMobile = (String? value) {
  // String patttern = r'^[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$';
  String patttern = r'^[\s-]?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'Masukan nomor HP';
  } else if (!regExp.hasMatch(value)) {
    return 'Nomor HP belum sesuai';
  }
  return null;
};

String? Function(String?) validateMobileAllCountry = (String? value) {
  // String patttern = r'^[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$';
  String patttern = r'^(?:\+?\d{1,3}|0)?([1-9]\d{7,12})$';
  RegExp regExp = RegExp(patttern);
  if (value!.isEmpty) {
    return 'Masukan nomor HP';
  } else if (!regExp.hasMatch(value)) {
    return 'Nomor HP belum sesuai';
  }
  return null;
};

String? Function(String?) validateMobileOrEmail = (String? value) {
  if (value!.isEmpty) {
    return 'Tidak boleh kosong';
  }

  bool phoneValid = RegExp(r'^[\s-]?0?8[1-9]{1}\d{1}[\s-]?\d{4}[\s-]?\d{2,5}$')
      .hasMatch(value);
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (emailValid) {
  } else if (phoneValid) {
  } else {
    return 'Format tidak sesusai';
  }
};

mobileZeroRemover(String? value, TextEditingController phoneController) {
  if (value!.length > 3) {
    if (value[0] == '0') {
      // String phone = value.substring(1);
      // setState(() {
      phoneController.text = value.substring(1);
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
      // });
    }
  }
  return null;
}

// -----------------------------------//
//-------------VALIDATOR--------------//

bottomSheet(
    {required BuildContext context,
    String? title,
    required Widget child,
    String? subtitle,
    Function()? onTapOk,
    Function()? onTapCancel,
    String? textOkButton,
    String? textCancelButton,
    bool? backButton = false,
    double? height}) {
  return showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: Container(
            color: Colors.white,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                indicatorModal(),
                if (title != null)
                  Container(
                    alignment: Alignment.center,
                    child: TextWidget(
                      title,
                      fontSize: Dimens.size24,
                      weight: FontWeight.bold,
                    ),
                  ),
                // if (subtitle != null)
                //   TextWidget(
                //     '$subtitle',
                //     size: TextWidgetSize.SMALL,
                //     color: Pallete.textPlaceholder,
                //   ).addMarginH(),
                // divideThick(margin: EdgeInsets.only(top: Dimens.size12)),
                divide12,
                // const Divider(
                //   height: 1,
                // ),
                child,
                Column(
                  children: [
                    divideThick(),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(Dimens.size16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (backButton!)
                            Expanded(
                              flex: 1,
                              child: RoundedButton(
                                  text: textCancelButton ?? 'Kembali',
                                  press: onTapCancel ??
                                      () {
                                        Navigator.pop(context);
                                      }),
                            ),
                          if (backButton) divideW8,
                          Expanded(
                            flex: 1,
                            child: RoundedButton(
                                text: textOkButton ?? 'Tutup',
                                press: () {
                                  Navigator.pop(context);
                                  if (onTapOk != null) {
                                    onTapOk();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Widget indicatorModal() {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.size8),
      width: 40,
      height: Dimens.size8,
      decoration: roundedDecoration(color: Colors.grey.shade200),
    ),
  );
}

ShapeBorder modalShape() {
  return RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.size16),
          topRight: Radius.circular(Dimens.size16)));
}

// void countryPicker({required BuildContext context}) {
//   return showCountryPicker(
//     context: context,
//     countryListTheme: const CountryListThemeData(
//       flagSize: 25,
//       backgroundColor: Colors.white,
//       textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
//       // bottomSheetHeight:
//       //     500, // Optional. Country list modal height
//       //Optional. Sets the border radius for the bottomsheet.
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20.0),
//         topRight: Radius.circular(20.0),
//       ),
//       //Optional. Styles the search field.
//       inputDecoration: InputDecoration(
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 10,
//           // vertical: 6,
//         ),
//         border: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         fillColor: Colors.red,
//         filled: true,
//         hintText: ('Cari'),
//         hintStyle: TextStyle(
//           color: Pallete.textPlaceholder,
//           fontSize: Dimens.size12,
//         ),
//         prefixIcon: Icon(
//           Iconly.search,
//           color: Colors.black,
//           size: 17,
//         ),
//       ),
//     ),
//     onSelect: (Country country) =>
//         print('Select country: ${country.displayName}'),
//   );
// }

Future<void> launchWa(String url) async {
  if (await canLaunch(url)) {
    await canLaunch(url)
        ? launch(url)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchWeb(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchMail(String url) async {
  var mail = 'mailto:$url';

  if (await canLaunch(mail)) {
    await launch(mail);
  } else {
    throw 'Could not launch email $mail';
  }
}

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (!await launchUrl(
    Uri.parse(googleUrl),
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch maps';
  }
}

Future<void> launchMapsUrl(double lat, double lon) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
