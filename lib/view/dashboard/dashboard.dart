import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/constants/app_color.dart';
import '../../../res/constants/value.dart';
import '../../view_model/home/home_view_models.dart';
import '../account/account.dart';
import '../home/home_view.dart';
import '../new_post/new_post.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final homeController = Get.put(HomeViewModel());

  final List<Widget> _widgetOptions = [
    const HomeView(),
    Account(),
    // const Account()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: primaryBackground,
        body: Center(
          child: _widgetOptions.elementAt(homeController.selectedIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.feed, size: 30),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 29),
              label: 'Account',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: secondaryBackground,
          elevation: 20,
          currentIndex: homeController.selectedIndex.value,
          // selectedIconTheme: const IconThemeData(color: primaryColor, opacity: 1),
          // unselectedIconTheme: IconThemeData(color: textSecondary, opacity: 1),
          selectedItemColor: primaryColor,
          unselectedItemColor: alternate,
          selectedLabelStyle:
              const TextStyle(fontSize: fontSmall, color: primaryColor),
          unselectedLabelStyle:
              const TextStyle(fontSize: fontSmall, color: alternate),
          onTap: (index) {
            setState(() {
              homeController.selectedIndex.value = index;
            });
          },
        ),
      );
    });
  }
}
