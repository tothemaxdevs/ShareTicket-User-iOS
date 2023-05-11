import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/account/bloc/account/account_bloc.dart';
import 'package:shareticket/modules/account/component/account_list_tile.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/account/model/account_data_result/account_data_result.dart';
import 'package:shareticket/modules/account/screen/change_language_screen.dart';
import 'package:shareticket/modules/account/screen/change_password_screen.dart';
import 'package:shareticket/modules/account/screen/profile_detail_screen.dart';
import 'package:shareticket/modules/account/screen/tos_privacy_screen.dart';
import 'package:shareticket/modules/home/screen/add_phone_screen.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class AccountArgument {
  final String title;

  AccountArgument(this.title);
}

class AccountScreen extends StatefulWidget {
  final AccountArgument? argument;

  const AccountScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/account';
  static const String title = 'Account';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? title;
  String? language;

  AccountBloc? _accountBloc;
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = AccountScreen.title;
    }
    getLanguage();

    _accountBloc = AccountBloc();
    _accountBloc!.add(GetAccountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider(
          create: (context) => _accountBloc!,
          child: BlocConsumer<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is GetAccountLoadingState) {
                  // return loading();
                  return _loadingView();
                } else if (state is GetAccountLoadedState) {
                  return _buildView(state.data);
                } else if (state is GetAccountErrorState) {
                  return IllustrationWidget(
                    type: IllustrationWidgetType.error,
                    onButtonTap: () {
                      _accountBloc!.add(GetAccountEvent());
                    },
                  );
                }
                return _loadingView();
              },
              listener: (context, state) => {
                    if (state is GetAccountLoadedState)
                      {
                        if (state.data.user!.phone == null) {_addPhoneDialog()}
                      }
                  }),
        ));
  }

  Widget _buildView(AccountDataResult data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size24),
        child: Column(
          children: [
            divide32,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
              child: Row(
                children: [
                  const SvgUI(
                    'ic_profile_blank.svg',
                    width: 46,
                    height: 46,
                  ),

                  // CircleAvatars(
                  //   imageUrl:
                  //       'https://mir-s3-cdn-cf.behance.net/project_modules/1400/61241a99666153.5ef7dbf39d0e2.jpg',
                  //   size: 62,
                  // ),
                  divideW10,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          data.user!.fullname,
                          weight: FontWeight.bold,
                          size: TextWidgetSize.h5,
                          maxLines: 1,
                          ellipsed: true,
                        ),
                        divide2,
                        TextWidget(
                          data.user!.email,
                          weight: FontWeight.w500,
                          textColor: Colors.grey,
                          size: TextWidgetSize.h7,
                          maxLines: 1,
                          ellipsed: true,
                        ),
                        // divide2,
                        // TextWidget(
                        //   data.user!.phone ?? 'Nomor hp belum ditambahkan',
                        //   weight: FontWeight.w500,
                        //   textColor: Colors.grey,
                        //   size: TextWidgetSize.h7,
                        //   maxLines: 1,
                        //   ellipsed: true,
                        // ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ProfileDetailScreen.path,
                            arguments: ProfileDetailArgument(data));
                      },
                      icon: Icon(Iconly.setting))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                  child: TextWidget(
                    LocaleKeys.account_settings.tr(),
                    textColor: Colors.grey,
                    size: TextWidgetSize.h6,
                    weight: FontWeight.w500,
                  ),
                ),
                // AccountTile(
                //   title: LocaleKeys.account_profile,
                //   icon: 'ic_account_profile.svg',
                //   isTick: false,
                //   onTap: () {
                //     Navigator.pushNamed(context, ProfileDetailScreen.path,
                //         arguments:
                //             ProfileDetailArgument(LocaleKeys.account_update));
                //   },
                // ),

                AccountTile(
                  title: LocaleKeys.account_password,
                  icon: 'ic_account_password.svg',
                  isTick: false,
                  onTap: () {
                    Navigator.pushNamed(context, ChanePasswordScreen.path,
                        arguments:
                            ChanePasswordArgument(userId: data.user!.id));
                  },
                ),
                AccountTile(
                  title: LocaleKeys.account_language,
                  icon: 'ic_account_language.svg',
                  subtitle: LocaleKeys.language_used,
                  isTick: false,
                  onTap: () {
                    Navigator.pushNamed(context, ChangeLanguageScreen.path);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                  child: TextWidget(
                    LocaleKeys.other_settings.tr(),
                    textColor: Colors.grey,
                    size: TextWidgetSize.h6,
                    weight: FontWeight.w500,
                  ),
                ),
                AccountTile(
                  title: LocaleKeys.account_tos,
                  icon: 'ic_account_tos.svg',
                  onTap: () {
                    Navigator.pushNamed(context, TosPrivacyScreen.path,
                        arguments:
                            TosPrivacyArgument(LocaleKeys.account_tos, true));
                  },
                ),
                AccountTile(
                  title: LocaleKeys.account_privacy,
                  icon: 'ic_account_privacy.svg',
                  onTap: () {
                    Navigator.pushNamed(context, TosPrivacyScreen.path,
                        arguments: TosPrivacyArgument(
                            LocaleKeys.account_privacy, false));
                  },
                ),
                AccountTile(
                    title: LocaleKeys.account_logout,
                    icon: 'ic_account_logout.svg',
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    isArrow: false,
                    isTick: false,
                    onTap: () {
                      // _googleSignIn
                      //     .signOut()
                      //     .then((value) {})
                      //     .catchError((e) {});
                      FirebaseAuth.instance.signOut();
                      LocalStorageService.removeValues();
                      // _googleSignIn.disconnect();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.path, (route) => false);
                    }),
              ],
            )
          ],
        ),
      ),
    );
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

  Widget _loadingView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.size24),
        child: Column(
          children: [
            divide32,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
              child: Row(
                children: [
                  const Blink(
                    height: 54,
                    width: 54,
                    isCircle: true,
                  ),

                  // CircleAvatars(
                  //   imageUrl:
                  //       'https://mir-s3-cdn-cf.behance.net/project_modules/1400/61241a99666153.5ef7dbf39d0e2.jpg',
                  //   size: 62,
                  // ),
                  divideW10,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Blink(height: 16, width: 140),
                        divide2,
                        const Blink(height: 16, width: 120),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.size16),
                    child: Blink(height: 12, width: 100)),
                loadingTile(),
                loadingTile(),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.size16),
                    child: Blink(height: 12, width: 100)),
                loadingTile(),
                loadingTile(),
                loadingTile(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget loadingTile() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              const Blink(
                height: 24,
                width: 24,
                isCircle: true,
              ),
              divideW20,
              const Blink(
                height: 16,
                width: 150,
                isCircle: true,
              ),
            ],
          ),
        ),
        divideThick(color: Colors.grey.shade100)
      ],
    );
  }

  getLanguage() async {
    var getLanguage = await LocalStorageService.getLanguage();
    setState(() {
      language = getLanguage;
    });
  }
}
