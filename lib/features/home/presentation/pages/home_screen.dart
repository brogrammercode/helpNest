import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl:
                    "https://cdn.dribbble.com/userupload/11053099/file/original-e98e2d290e832cf1bc654e5eb86be778.png?resize=1600x1200&vertical=center"),
          ],
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 65.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.menu_1),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.grey.withOpacity(.3)))),
              ),
            ],
          ),
          title: Text(
            "helpNest",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.location),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(.3)))),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.grey.withOpacity(.3)))),
            ),
          ],
        ),
      ),
    );
  }
}
