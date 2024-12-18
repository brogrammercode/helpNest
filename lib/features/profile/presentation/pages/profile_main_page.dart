import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({super.key});

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 135.h,
                width: 135.h,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 125.h,
                    width: 125.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.15),
                              blurRadius: 10)
                        ],
                        border: Border.all(color: Colors.white, width: 7.w)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                            height: 125.h,
                            width: 125.h,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://cdn.dribbble.com/userupload/16281153/file/original-b6ff14bfc931d716c801ea7e250965ce.png?resize=1600x1200&vertical=center")),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text("Credence Anderson",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 30.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.frame_1),
                      SizedBox(width: 20.w),
                      const Text("Your Profile",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.briefcase),
                      SizedBox(width: 20.w),
                      const Text("Become a Service Provider",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.info_circle),
                      SizedBox(width: 20.w),
                      const Text("Report a safety emergency",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.support),
                      SizedBox(width: 20.w),
                      const Text("Support",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.edit_2),
                      SizedBox(width: 20.w),
                      const Text("Send Feedback",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.more_circle),
                      SizedBox(width: 20.w),
                      const Text("About",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.shield_tick),
                      SizedBox(width: 20.w),
                      const Text("Privacy Policy",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.receipt_1),
                      SizedBox(width: 20.w),
                      const Text("Terms and Conditions",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.unlock),
                      SizedBox(width: 20.w),
                      const Text("Log out",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_3)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 65.h),
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: AppBar(
          title: Text(
            "My Profile",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.menu_1),
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
