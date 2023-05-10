import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/core/splash/app_version/app_version.dart';
import 'package:shareticket/core/splash/bloc/app_version_bloc.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:store_redirect/store_redirect.dart';

// class SplashArgument {
//   final String title;

//   SplashArgument(this.title);
// }

// class SplashScreen extends StatefulWidget {
//   final SplashArgument? argument;

//   const SplashScreen({Key? key, this.argument}) : super(key: key);

//   static const String path = '/splash';
//   static const String title = 'Splash';

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   String? title;

//   @override
//   void initState() {
//     if (widget.argument != null) {
//       title = widget.argument?.title;
//     } else {
//       title = SplashScreen.title;
//     }
//     startSplashScreen();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
//     //   SystemUiOverlay.top,
//     // ]);

//     return const Scaffold(
//       backgroundColor: Pallete.primary,
//       body: Center(
//           child: SvgUI(
//         'ic_logo.svg',
//         width: 200,
//       )),
//     );
//   }

//   startSplashScreen() {
//     var duration = const Duration(seconds: 2);
//     return Timer(duration, () async {
//       checkIsLogin();
//     });
//   }

//   Future<void> checkIsLogin() async {
//     bool isLogin = await LocalStorageService.checkLogin();

//     if (isLogin) {
//       Navigator.pushNamedAndRemoveUntil(
//           context, DashboardScreen.path, (route) => false,
//           arguments: DashboardArgument(currentTab: 0));
//     } else {
//       Navigator.pushNamedAndRemoveUntil(
//           context, LoginScreen.path, (route) => false);
//     }
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();

  static const String path = '/splash';
}

class _SplashScreenState extends State<SplashScreen> {
  late AppVersionBloc appVersionFromApiBloc;
  late AppVersionBloc appVersionFromInfoBloc;

  String vInfo = '';
  String vApi = '';
  String description = '';

  Map<String, dynamic> params = {};

  @override
  void initState() {
    params['type'] = 'ios_customer';

    appVersionFromApiBloc = AppVersionBloc();
    appVersionFromInfoBloc = AppVersionBloc();

    appVersionFromInfoBloc.add(GetAppVersionFromInfoEvent());
    super.initState();
    startSplashScreen();
  }

  @override
  void dispose() {
    appVersionFromApiBloc.close();
    appVersionFromInfoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Pallete.primary,
        body: BlocListener<AppVersionBloc, AppVersionState>(
          bloc: appVersionFromApiBloc,
          listener: (context, state) {
            if (state is AppVersionLoadedState) {
              vApi = state.appVersion.version!;
              // vApi = '1.1.0';
              log('vInfo: $vInfo');
              log('vApi : $vApi');
              if (isUpdated(vInfo, vApi) == false) {
                checkIsLogin();
              } else {
                showUpdateDialog(state.appVersion);
              }
            } else if (state is AppVersionErrorState) {
              checkIsLogin();
            }
          },
          child: _buildView(),
        ),
      ),
    );
  }

  Widget _buildView() {
    return Stack(
      children: [
        const Positioned(
          child: Align(
            alignment: Alignment.center,
            child: SvgUI(
              'ic_logo.svg',
              width: 200,
            ),
          ),
        ),
        BlocBuilder<AppVersionBloc, AppVersionState>(
          bloc: appVersionFromInfoBloc,
          builder: (context, state) {
            if (state is AppVersionInitialState) {
              log('STATE $state');
              return Container();
            } else if (state is AppVersionInfoLoadedState) {
              // log('STATE $state');
              vInfo = state.appVersion;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextWidget(
                    'v$vInfo',
                    textColor: Colors.white,
                    size: TextWidgetSize.h7,
                    weight: FontWeight.w600,
                  ),
                ),
              );
            } else {
              log('STATE $state');
              return Container();
            }
          },
        ),
      ],
    );
  }

  Future<void> checkIsLogin() async {
    bool isLogin = await LocalStorageService.checkLogin();

    if (isLogin) {
      Navigator.pushNamedAndRemoveUntil(
          context, DashboardScreen.path, (route) => false,
          arguments: DashboardArgument(currentTab: 0));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.path, (route) => false);
    }
  }

  showUpdateDialog(AppVersion data) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return DialogBox(
          title: 'Aplikasi terbaru tersedia!',
          descriptions: data.description,
          onOkText: 'Perbaharui',
          onOkTap: () {
            // Navigator.pop(context);
            StoreRedirect.redirect(
              androidAppId: 'com.sticket.user',
              iOSAppId: 'com.sticket.user',
            );
          },
          isOkPrimary: data.skip == true ? false : true,
          enableCancel: data.skip == true ? true : false,
          onCancelText: 'Lewati',
          onCancelTap: () {
            // skipUpdateSplashScreen();
            // showToast('Batal');
            Navigator.pop(context);
            checkIsLogin();
          },
        );
      },
    );
  }

  bool isUpdated(String currentVersion, String updatedVersion) {
    if (Version.parse(updatedVersion) > Version.parse(currentVersion)) {
      log('isUpdated: true');
      return true;
    } else {
      log('isUpdated: false');
      return false;
    }
  }

  //  startSplashScreen() async {
  //   var duration = const Duration(seconds: 2);
  //   return Timer(duration, () {
  //     checkIsLogin();
  //     // Navigator.pushReplacementNamed(context, RouteConfig.ON_BOARDING);
  //   });
  // }

  startSplashScreen() {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () async {
      appVersionFromApiBloc.add(GetAppVersionFromApiEvent(params));
    });
  }
}
