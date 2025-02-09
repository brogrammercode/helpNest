import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/home/presentation/cubit/home_cubit.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:helpnest/features/order/presentation/pages/history_page.dart';
import 'package:helpnest/features/home/presentation/pages/home_screen.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';
import 'package:helpnest/features/profile/presentation/pages/profile_main_page.dart';
import 'package:helpnest/features/search/presentation/cubit/search_cubit.dart';
import 'package:helpnest/features/search/presentation/pages/search_page.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:helpnest/features/service/presentation/pages/service_main_page.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  // int _bottomNavIndex = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    context.read<HomeCubit>().getLocationFromDatabase();
    context.read<OrderCubit>().initOrderSubscription();
    context.read<ServiceCubit>().getServices();
    context.read<SearchCubit>().getSearchKeywords();
    context.read<ProfileCubit>().getAppFeedback();
    context.read<HomeCubit>().initializeIsLocationEnabledListener();
    final position = context.read<HomeCubit>().state.position;
    context.read<HomeCubit>().getAdBanner(position: position);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: _buildBottomNavBar(
              context: context, currentIndex: state.bottomNavIndex),
          body: _buildBody(currentIndex: state.bottomNavIndex),
        );
      },
    );
  }

  /// Builds the bottom navigation bar.
  Widget _buildBottomNavBar(
      {required BuildContext context, required int currentIndex}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomNavButton(
            context,
            icon: Iconsax.home,
            index: 0,
            currentIndex: currentIndex,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.briefcase,
            index: 1,
            currentIndex: currentIndex,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.search_normal_1,
            index: 2,
            currentIndex: currentIndex,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.receipt,
            index: 3,
            currentIndex: currentIndex,
          ),
          _buildBottomNavButton(
            context,
            icon: Iconsax.frame_1,
            index: 4,
            currentIndex: currentIndex,
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
    required int currentIndex,
  }) {
    final bool isSelected = currentIndex == index;
    return IconButton(
      onPressed: () =>
          context.read<HomeCubit>().updateBottomNavIndex(index: index),
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
  Widget _buildBody({required int currentIndex}) {
    switch (currentIndex) {
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
