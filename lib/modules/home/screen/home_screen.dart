import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/bloc/account/account_bloc.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/appbar_action_button.dart';
import 'package:shareticket/modules/home/screen/add_phone_screen.dart';
import 'package:shareticket/modules/home/screen/location_picker_screen.dart';
import 'package:shareticket/modules/home/widget/article_list_widget.dart';
import 'package:shareticket/modules/home/widget/category_list_widget.dart';
import 'package:shareticket/modules/home/widget/event_group_widget.dart';
import 'package:shareticket/modules/home/widget/event_list_widget.dart';
import 'package:shareticket/modules/home/widget/promo_list_widget.dart';
import 'package:shareticket/modules/notification/screen/notification_screen.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class HomeArgument {
  final String title;

  HomeArgument(this.title);
}

class HomeScreen extends StatefulWidget {
  final HomeArgument? argument;

  const HomeScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/home';
  static const String title = 'Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? title;
  String? cityId;
  String? provinceId;
  String address = 'Loading..';
  String sddreaass = 'search';

  bool servicestatus = false;
  bool haspermission = false;
  bool isLoadingLatLng = true;

  HomeBloc? popularBloc;
  HomeBloc? nearByBloc;
  AccountBloc? accountBloc;

  final Map<String, dynamic> paramsPopular = Map();
  final Map<String, dynamic> paramsNearBy = Map();

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = HomeScreen.title;
    }
    loadDataInit();

    paramsNearBy['city_id'] = cityId;
    nearByBloc = HomeBloc();
    popularBloc = HomeBloc();
    accountBloc = AccountBloc();

    popularBloc!.add(GetListWidgetEventEvent(paramsPopular));
    accountBloc!.add(GetAccountEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.screenBackground,
        body: RefreshIndicator(
          onRefresh: () async {
            popularBloc!.add(GetListWidgetEventEvent(paramsPopular));
            nearByBloc!.add(GetListWidgetEventEvent(paramsNearBy));
          },
          child: Column(
            children: [
              customAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EventListWidget(
                        isLarge: true,
                        title: LocaleKeys.home_popular_event.tr(),
                        homeBloc: popularBloc!,
                      ),
                      EventGroupWidget(title: 'Tenant'),
                      CategoryListWidget(
                          title: LocaleKeys.home_event_category.tr()),
                      PromoListWidget(
                          title: LocaleKeys.home_promo_and_information.tr()),
                      divide10,
                      EventListWidget(
                        cityId: cityId,
                        isLarge: false,
                        title: LocaleKeys.home_near_by_event.tr(),
                        homeBloc: nearByBloc!,
                      ),
                      ArticleListWidget(
                        title: LocaleKeys.home_article.tr(),
                      ),
                      divide16,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.size16, vertical: Dimens.size10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    const SvgUI(
                      'ic_profile_blank.svg',
                      width: 38,
                      height: 38,
                    ),
                    divideW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          LocaleKeys.login_hello.tr(),
                          size: TextWidgetSize.h7,
                          weight: FontWeight.w500,
                          textColor: Colors.grey,
                        ),
                        BlocProvider(
                            create: (context) => accountBloc!,
                            child: BlocConsumer<AccountBloc, AccountState>(
                                builder: (context, state) {
                                  if (state is GetAccountLoadingState) {
                                    // return loading();
                                    return const Blink(height: 16, width: 160);
                                  } else if (state is GetAccountLoadedState) {
                                    return TextWidget(
                                      state.data.user!.fullname,
                                      size: TextWidgetSize.h6,
                                      weight: FontWeight.bold,
                                      textColor: Pallete.primary,
                                    );
                                  } else if (state is GetAccountErrorState) {
                                    return Container();
                                  }
                                  return const Blink(height: 16, width: 160);
                                },
                                listener: (context, state) => {
                                      if (state is GetAccountLoadedState)
                                        {
                                          LocalStorageService.setUserId(
                                              state.data.user!.id!),
                                          LocalStorageService.setUserName(
                                              state.data.user!.fullname),
                                          if (state.data.user!.phone == null)
                                            {_addPhoneDialog()}
                                        }
                                    }))
                      ],
                    )
                  ],
                ),
              ),
              divideW8,
              AppBarActionButton(
                icon: 'ic_appbar_notification.svg',
                onTap: () {
                  Navigator.pushNamed(context, NotificationScreen.path);
                },
              )
            ],
          ),
          divide10,
          InkWell(
            onTap: () async {
              // Navigator.pushNamed(context, MapPicker.path);
              var isUpdated =
                  await Navigator.pushNamed(context, LocationPickerScreen.path);

              if (isUpdated == true) {
                loadDataInit();
                // paramsNearBy['city_id'] = cityId;
                // nearByBloc!.add(GetEventEvent(paramsNearBy));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  color: Colors.grey.shade100),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: Pallete.primary.withAlpha(25),
                          ),
                          child: const Icon(
                            Iconly.location_bold,
                            color: Pallete.primary,
                            size: 15,
                          ),
                        ),
                        divideW6,
                        Flexible(
                          child: TextWidget(
                            address,
                            ellipsed: true,
                            textColor: Pallete.primary,
                            size: TextWidgetSize.h7,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  divideW10,
                  Container(
                      margin: const EdgeInsets.all(2),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: Pallete.accentColor.withAlpha(50),
                      ),
                      child: TextWidget(
                        '  ${LocaleKeys.core_change.tr()}  ',
                        textColor: Pallete.accentColor,
                        size: TextWidgetSize.h7,
                        weight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ),
          divide10,
        ],
      ),
    );
  }

  void loadDataInit() async {
    String city = await LocalStorageService.getCity();
    String province = await LocalStorageService.getProvince();
    String cityProvince = await LocalStorageService.getCityProvince();

    setState(() {
      cityId = city;
      provinceId = province;
      address = cityProvince;
    });

    log('City id $cityId');
    log('Province id $province');
    log('Province id $address');

    paramsNearBy['city_id'] = cityId;
    nearByBloc!.add(GetListWidgetEventEvent(paramsNearBy));
  }

  _addPhoneDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return DialogBox(
          title: 'Tambahkan nomor handphone',
          descriptions:
              'Akun anda belum memiliki nomor handphone, silahkan tambahkan terlebih dahulu.',
          onOkText: 'Tambahkan nomor',
          onOkTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AddPhoneNumberScreen.path);
          },
          isOkPrimary: true,
        );
      },
    );
  }

  // Future<void> getAddressFromLatLong(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(52.2165157, 6.9437819);
  //   log(placemarks.toString());
  //   Placemark place = placemarks[0];

  //   setState(() {
  //     address =
  //         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   });
  // }
}
