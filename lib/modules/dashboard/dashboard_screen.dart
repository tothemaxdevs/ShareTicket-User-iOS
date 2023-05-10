import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/config/size/size.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/screen/account_screen.dart';
import 'package:shareticket/modules/home/screen/home_screen.dart';
import 'package:shareticket/modules/ticket/screen/my_ticket_screen.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

class DashboardArgument {
  final int? currentTab;
  DashboardArgument({this.currentTab});
}

class DashboardScreen extends StatefulWidget {
  final DashboardArgument? argument;

  const DashboardScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/dashboard';
  static const String title = 'Dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? title;
  int currentTab = 0;
  DateTime? currentBackPressTime;

  List<BottomNavigationBarItem> navItems = [];
  final List<Widget> screens = [
    const HomeScreen(),
    // const ChatScreen(),
    const MyTicketScreen(),
    const AccountScreen(),
  ];

  PageController? _pageController;

  void _onItemTapped(int index) {
    setState(() {
      currentTab = index;
      _pageController!.jumpToPage(currentTab);
    });
  }

  @override
  void initState() {
    // setState(() {
    //   currentTab = widget.initialPage!;
    // });
    // if (widget.argument!.title != null) {
    //   title = widget.argument?.title;
    // } else {
    //   title = DashboardScreen.title;
    // }

    if (widget.argument != null) {
      setState(() {
        currentTab = widget.argument!.currentTab!;
      });
    }
    // setState(() {
    //   currentTab = widget.argument!.currentTab!;
    // });

    _pageController = PageController(initialPage: currentTab);

    Future.delayed(Duration.zero, () {
      // NotificationManager.init(context: context);
      // Fcm.initConfigure(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initSizeConfig(context);

    navItems = [
      BottomNavigationBarItem(
        icon: const SvgUI('navbar/ic_home_inactive.svg'),
        activeIcon: const SvgUI('navbar/ic_home_active.svg'),
        label: LocaleKeys.home.tr(),
      ),
      // const BottomNavigationBarItem(
      //     icon: SvgUI('navbar/ic_chat_inactive.svg'),
      //     activeIcon: SvgUI('navbar/ic_chat_active.svg'),
      //     label: ''),
      BottomNavigationBarItem(
        icon: const SvgUI('navbar/ic_ticket_inactive.svg'),
        activeIcon: const SvgUI('navbar/ic_ticket_active.svg'),
        label: LocaleKeys.ticket.tr(),
      ),
      BottomNavigationBarItem(
        icon: const SvgUI('navbar/ic_account_inactive.svg'),
        activeIcon: const SvgUI('navbar/ic_account_active.svg'),
        label: LocaleKeys.account.tr(),
      ),
    ];
    return Scaffold(
      body: WillPopScope(
        onWillPop: onExit,
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          child: SizedBox(
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(
                  fontSize: Dimens.size10, fontWeight: FontWeight.w500),
              unselectedLabelStyle: const TextStyle(fontSize: Dimens.size10),
              backgroundColor: Colors.white,
              selectedItemColor: Pallete.primary,
              unselectedItemColor: const Color(0xFFBDBDBD),

              // showUnselectedLabels: false,
              elevation: 0.0,
              // showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: navItems,
              currentIndex: currentTab,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Klik dua kali untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
