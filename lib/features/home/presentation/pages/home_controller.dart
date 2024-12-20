import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/history/presentation/pages/history_page.dart';
import 'package:helpnest/features/home/presentation/pages/home_screen.dart';
import 'package:helpnest/features/profile/presentation/pages/profile_main_page.dart';
import 'package:helpnest/features/search/presentation/pages/search_page.dart';
import 'package:helpnest/features/service/presentation/pages/service_main_page.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(context),
      body: _buildBody(),
    );
  }

  /// Builds the bottom navigation bar.
  Widget _buildBottomNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomNavButton(
            context,
            icon: Iconsax.home,
            index: 0,
          ),
          
          _buildBottomNavButton(
            context,
            icon: Iconsax.briefcase,
            index: 1,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.search_normal_1,
            index: 2,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.receipt,
            index: 3,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.frame_1,
            index: 4,
          ),
        ],
      ),
    );
  }

  /// Builds each bottom navigation button.
  Widget _buildBottomNavButton(
    BuildContext context, {
    required IconData icon,
    required int index,
  }) {
    final bool isSelected = _bottomNavIndex == index;
    return IconButton(
      onPressed: () => setState(() => _bottomNavIndex = index),
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Theme.of(context).iconTheme.color,
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundColor:
            isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }

  /// Determines which page to display based on the selected index.
  Widget _buildBody() {
    switch (_bottomNavIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ServiceMainPage();
      case 2:
        return const SearchPage();
      case 3:
        return const HistoryPage();
      case 4:
        return const ProfileMainPage();
      default:
        return const Placeholder(); // Fallback for unexpected indices.
    }
  }
}
