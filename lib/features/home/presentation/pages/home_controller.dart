import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/history/presentation/pages/history_page.dart';
import 'package:helpnest/features/home/presentation/pages/home_screen.dart';
import 'package:helpnest/features/profile/presentation/pages/profile_main_page.dart';
import 'package:helpnest/features/search/presentation/pages/search_page.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(context),
      body: _body(),
    );
  }

  Padding _bottomNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  backgroundColor: bottomNavIndex == 0
                      ? Theme.of(context).primaryColor
                      : null),
              onPressed: () {
                setState(() => bottomNavIndex = 0);
              },
              icon: Icon(
                Iconsax.home,
                color: bottomNavIndex == 0 ? Colors.white : null,
              )),
          IconButton(
              onPressed: () {
                setState(() => bottomNavIndex = 1);
              },
              icon: Icon(
                Iconsax.search_normal_1,
                color: bottomNavIndex == 1 ? Colors.white : null,
              ),
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  backgroundColor: bottomNavIndex == 1
                      ? Theme.of(context).primaryColor
                      : null)),
          IconButton(
              onPressed: () {
                setState(() => bottomNavIndex = 2);
              },
              icon: Icon(
                Iconsax.briefcase,
                color: bottomNavIndex == 2 ? Colors.white : null,
              ),
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  backgroundColor: bottomNavIndex == 2
                      ? Theme.of(context).primaryColor
                      : null)),
          IconButton(
              onPressed: () {
                setState(() => bottomNavIndex = 3);
              },
              icon: Icon(
                Iconsax.receipt,
                color: bottomNavIndex == 3 ? Colors.white : null,
              ),
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  backgroundColor: bottomNavIndex == 3
                      ? Theme.of(context).primaryColor
                      : null)),
          IconButton(
              onPressed: () {
                setState(() => bottomNavIndex = 4);
              },
              icon: Icon(
                Iconsax.frame_1,
                color: bottomNavIndex == 4 ? Colors.white : null,
              ),
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  backgroundColor: bottomNavIndex == 4
                      ? Theme.of(context).primaryColor
                      : null)),
        ],
      ),
    );
  }

  _body() {
    switch (bottomNavIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchPage();
      case 2:
        return const HomeScreen();
      case 3:
        return const HistoryPage();
      default:
        return const ProfileMainPage();
    }
  }
}
