import 'package:flutter/material.dart';
import 'package:shareticket/utils/view/view_utils.dart';

class AuthManager {
  static BuildContext? _context;

  static init({@required BuildContext? context}) {
    _context = context;
  }

  static handleDataMsg(Map<String, dynamic> data) {}

  static handleNotification(BuildContext context, String message, String code) {
    // log(data['code'].toString());
    // var id = data['target_id'];
    // var code = data['code'];
    // var group_id = data['group_id'];
    // // CHAT PERSONAL
    // var room_id = data['room_id'];
    // var target_id = data['target_id'];
    // // FORUM
    // var forum_id = data['forum_id'];

    // if (code == 'GROUP') {
    //   Navigator.pushNamed(context, CommunityChatScreen.path,
    //       arguments: CommunityChatArgument(group_id));
    //   // showToast('GROUP');
    // } else if (code == 'CHAT') {
    //   Navigator.pushNamed(context, ChatMainScreen.path,
    //       arguments: ChatMainArgument(room_id, target_id));
    //   // showToast('GROUP');
    // } else if (code == 'FORUM') {
    //   // showToast('Forum');
    //   Navigator.pushNamed(context, ForumChatScreen.path,
    //       arguments: ForumChatArgument(forum_id));
    //   showToast(SharedPreferencesHelper.isAdmin);
    // } else {
    //   showToast('CODE');
    // }
    // else if (data['type'] == 'DINEIN') {
    //   Navigator.pushNamed(context, OrderDetailScreen.path,
    //       arguments: new OrderDetailArgument('$type'.toUpperCase(), '$id'));
    //   // } else if (data['type'] == 'INFORMASI') {
    //   //   Navigator.pushNamed(context, NotifactionDetailScreen.path,
    //   //       arguments: new NotificationDetailArgument(
    //   //           '${notification.title}',
    //   //           '${notification.date}',
    //   //           '${notification.description}'));
    // } else if (data['type'] == 'RATING') {
    //   Navigator.pushNamed(context, ReplyRatingScreen.path,
    //       arguments: new ReplyRatingArgument('DETAIL RATING', '$id'));
    // } else if (data['type'] == 'WAITER') {
    //   Navigator.pushNamed(context, ReplyWaiterScreen.path,
    //       arguments: new ReplyWaiterArgument('DETAIL WAITER', '$id'));
    // } else if (data['type'] == 'CONTENT') {
    //   Navigator.pushNamed(context, NewsDetailScreen.path,
    //       arguments: NewsDetailArgument('', '$id'));
    // } else if (data['type'] == 'WAITINGLIST') {
    //   Navigator.pushNamed(context, WaitinglistScreen.path);
    // }

    // if (data['type'] == 'reservation') {
    //   // _showDialogReservation(jsonDecode(data['data']));
    //   RouteUtil.goToDetailOrder(context, id: id);
    // } else if (data['type'] == 'waiting-list') {
    //   // WaitinglistAuthManager.showNotification(_context!,
    //   //     data: data, notification: notification!);
    // }
  }

  static handleNotificationMsg(String code, String message) {
    if (code == '401') {
      showToast('anda ter logout gaes');
      // _showDialogReservation();

    }
  }

//   static _showDialogWaitingList(data) {
//     showCustomDialog(_context!, 'WaitingList baru',
//         textOk: 'Proses',
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextIcon(
//               title: '${data['user']['name']}',
//               icon: 'ic_order_user.svg',
//             ),
//             divide6,
//             TextIcon(
//               title: '${data['guest_count']}',
//               icon: 'ic_order_guest.svg',
//             ),
//             divide6,
//             TextIcon(
//               title: '${data['room']['name']}',
//               icon: 'ic_order_room.svg',
//             ),
//           ],
//         ),
//         tapOk: () {});
//   }
}
