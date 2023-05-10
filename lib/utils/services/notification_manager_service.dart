// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationManager {
//   static BuildContext? _context;

//   static init({@required BuildContext? context}) {
//     _context = context;
//   }

//   static handleDataMsg(Map<String, dynamic> data) {}

//   static handleNotification(
//     BuildContext context,
//     Map<String, dynamic> data, {
//     RemoteNotification? notification,
//   }) {
//     log('--------------------');
//     log(data['code'].toString());
//     log(data['target_id']);
//     log(data.toString());
//     log('--------------------');
//   }

//   static handleNotificationMsg(Map<String, dynamic> message) {
//     debugPrint("from managger  $message");

//     final dynamic data = message;
//     // if (data['type'] == 'reservation') {
//     //   var dataJson = jsonDecode(data['data']);
//     //   print(dataJson['user_name']);
//     //   // _showDialogReservation(dataJson);
//     // } else if (data['type'] == 'waiting-list') {
//     //   var dataJson = jsonDecode(data['data']);
//     //   print(dataJson);
//     //   _showDialogWaitingList(dataJson);
//     // }
//   }
// }
