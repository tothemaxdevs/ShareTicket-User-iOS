// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shareticket/utils/services/notification_manager_service.dart';

// class Fcm {
//   static initConfigure(BuildContext context) async {
//     log('INITIALIZING FIREBASE MESSANGING');
//     final FlutterLocalNotificationsPlugin localNotification =
//         FlutterLocalNotificationsPlugin();

//     var androidSettings = const AndroidInitializationSettings(
//       'mipmap/ic_launcher',
//     ); // <- default icon name is @mipmap/ic_launcher
//     // var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     var settings =
//         InitializationSettings(android: androidSettings, macOS: null);

//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings notifSettings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: true,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     FirebaseMessaging.instance.subscribeToTopic('content');

//     // AndroidNotificationDetails androidPlatformChannelSpecifics =
//     //     AndroidNotificationDetails(
//     //   'high_importance_channel',
//     //   'SOBAT_PEPEP_ID',
//     //   channelDescription: 'your channel description',
//     //   importance: Importance.max,
//     //   priority: Priority.high,
//     //   ticker: 'ticker',
//     //   playSound: true,
//     // );

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       log('on clicked');
//       log('NOTIF BACKGROUND: ${message.data}');

//       await NotificationManager.handleNotification(
//         context,
//         message.data,
//         notification: message.notification as RemoteNotification,
//       );
//     });

//     localNotification.initialize(
//       settings,
//       // onSelectNotification: (payload) =>
//       //     Fcm.selectNotification(context, payload),
//     );

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       log('on clicked 2');
//       log('NOTIF FOREGROUND: ${message.data}');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification!.android;

//       BigPictureStyleInformation? bigPictureStyleInformation;

//       if (message.notification!.android!.imageUrl != null) {
//         final String largeIconPath = await _downloadAndSaveFile(
//             '${message.notification!.android!.imageUrl}', 'largeIcon');
//         final String bigPicturePath = await _downloadAndSaveFile(
//             '${message.notification!.android!.imageUrl}', 'bigPicture');

//         bigPictureStyleInformation = BigPictureStyleInformation(
//             FilePathAndroidBitmap(bigPicturePath),
//             largeIcon: FilePathAndroidBitmap(largeIconPath),
//             htmlFormatContent: true,
//             htmlFormatSummaryText: true,
//             summaryText: message.notification!.body);
//       }

//       AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails('high_importance_channel', 'octagon_ID',
//               channelDescription: 'your channel description',
//               importance: Importance.max,
//               priority: Priority.high,
//               ticker: 'ticker',
//               playSound: true,
//               styleInformation: bigPictureStyleInformation);

//       NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);

//       if (notification != null) {
//         localNotification.show(notification.hashCode, notification.title,
//             notification.body, platformChannelSpecifics,
//             payload: jsonEncode(message.data));
//       }
//       NotificationManager.handleNotification(
//         context,
//         message.data,
//         notification: message.notification as RemoteNotification,
//       );
//     });
//   }

//   static void showNotification(BuildContext context, title, body) {
//     final FlutterLocalNotificationsPlugin localNotification =
//         FlutterLocalNotificationsPlugin();

//     var androidSettings = const AndroidInitializationSettings(
//       'mipmap/ic_launcher',
//     );
//     var settings =
//         InitializationSettings(android: androidSettings, macOS: null);

//     localNotification.initialize(
//       settings,
//       // onSelectNotification: (payload) =>
//       //     Fcm.selectNotification(context, payload),
//     );

//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         const AndroidNotificationDetails(
//       'high_importance_channel',
//       'octagon_ID',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//       playSound: true,
//     );

//     NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     localNotification.show(
//       title.hashCode,
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }

//   static Future selectNotification(
//       BuildContext context, String? payload) async {
//     NotificationManager.handleNotification(context, jsonDecode(payload!));
//   }

//   static Future<String> _downloadAndSaveFile(
//       String url, String fileName) async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final Response response = await get(Uri.parse(url));
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }

//   // static _iosPermission() {
//   //   _fcm.requestNotificationPermissions(
//   //       IosNotificationSettings(sound: true, badge: true, alert: true));
//   //   _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
//   //     print("Settings registered: $settings");
//   //   });
//   // }

// }
