// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/routes.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(),
            SizedBox(height: 20.h),
            _buildSectionTitle(context, "Services"),
            _buildServiceGrid(),
            SizedBox(height: 10.h),
            _buildSectionTitle(context, "Popular"),
            _buildHorizontalScroll(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  /// Builds the custom app bar.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: _buildIconButton(Iconsax.menu_1, () {}),
          title: Text(
            "helpNest",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            _buildIconButton(Iconsax.location, () {}),
            _buildIconButton(Iconsax.notification, () {}),
          ],
        ),
      ),
    );
  }

  /// Builds a reusable circular icon button.
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
      ),
    );
  }

  /// Builds the main header image.
  Widget _buildHeaderImage() {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.services.isEmpty) {
          return SizedBox(height: 250.h);
        }

        final randomService = (state.services..shuffle()).first;
        return CachedNetworkImage(
          height: 250.h,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: randomService.slides[0],
          placeholder: (context, url) => SizedBox(
            height: 250.h,
            child: const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error, size: 50.w),
        );
      },
    );
  }

  /// Builds the grid of services.
  Widget _buildServiceGrid() {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.h),
          itemCount: state.services.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final service = state.services[index];
            return _buildServiceItem(
                title: service.name,
                imageUrl: service.logo,
                onPressed: () async {
                  await context
                      .read<ServiceCubit>()
                      .updateServiecID(serviceID: service.id);
                  Navigator.pushNamed(
                      context, AppRoutes.serviceProviderListPage);
                });
          },
        );
      },
    );
  }

  /// Builds an individual service item for the grid.
  Widget _buildServiceItem(
      {required String title,
      required String imageUrl,
      required void Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3)),
              ],
            ),
            padding: EdgeInsets.all(15.w),
            child: CachedNetworkImage(
              height: 35.h,
              width: 35.h,
              fit: BoxFit.contain,
              imageUrl: imageUrl,
              placeholder: (context, url) => SizedBox(
                height: 40.h,
                width: 40.h,
                child: const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, size: 40.w),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds the title for a section.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 10.h),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Builds the horizontal scroll view for popular items.
  Widget _buildHorizontalScroll() {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.services.isEmpty) {
          return SizedBox(height: 250.h);
        }
        final randomService = (state.services..shuffle()).first;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.w),
              ...randomService.slides.map((url) => _buildPopularItem(url)),
              SizedBox(width: 20.w),
            ],
          ),
        );
      },
    );
  }

  /// Builds an individual popular item.
  Widget _buildPopularItem(String imageUrl) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CachedNetworkImage(
          height: 250.h,
          width: 350.w,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => SizedBox(
            height: 250.h,
            width: 350.w,
            child: const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error, size: 50.w),
        ),
      ),
    );
  }

  void _init() async {
    context.read<ServiceCubit>().getServices();
  }
}
