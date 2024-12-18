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
            GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                itemCount: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: .8),
                itemBuilder: (context, index) {
                  return IconButton(
                      onPressed: () {},
                      icon: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                                height: 60.h,
                                width: 60.h,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://cdn.dribbble.com/userupload/16782566/file/original-a1e8dab093cbde95aa248729ef505ae8.png?resize=1200x900&vertical=center"),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Plumber",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ));
                }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              margin: EdgeInsets.only(bottom: 30.h),
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        height: 250.h,
                        width: 350.w,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://cdn.dribbble.com/userupload/16836268/file/original-e8e0c80d5364357af82908db651475e0.png?resize=1024x1025&vertical=center"),
                  ),
                  SizedBox(width: 10.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        height: 250.h,
                        width: 350.w,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://cdn.dribbble.com/userupload/17223940/file/original-bc2bebdff2f7f6d38fecbd0046559099.png?resize=1600x1200&vertical=center"),
                  ),
                  SizedBox(width: 20.w),
                ],
              ),
            ),
            SizedBox(height: 10.h),
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
