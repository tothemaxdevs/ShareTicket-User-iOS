import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/config/routes/routes.config.dart';
import 'package:shareticket/config/theme/theme.config.dart';
import 'package:shareticket/core/splash/splash_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/services/navigator_key.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum PageMode { loading, loaded, empty, error }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/i18n',
        startLocale: const Locale('id'),
        saveLocale: true,
        // fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  IO.Socket? socket;

  @override
  void initState() {
    // firebaseConfiguration();
    super.initState();
  }

  @override
  void dispose() {
    socket!.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'shareticket',
      theme: theme(),
      initialRoute: SplashScreen.path,
      onGenerateRoute: RouteConfig.generateRoute,
    );
  }

  // void firebaseConfiguration() async {
  //   String? token = await messaging.getToken();

  //   if (token != null) {
  //     log('FCM TOKEN $token');
  //     LocalStorageService.setTokenFCM(token);
  //   }
  // }
}
