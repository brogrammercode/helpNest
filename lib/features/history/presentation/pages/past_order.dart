import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class PastOrder extends StatefulWidget {
  const PastOrder({super.key});

  @override
  State<PastOrder> createState() => _PastOrderState();
}

class _PastOrderState extends State<PastOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Credence Anderson",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 200.w,
                height: 150.h,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
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
                            border:
                                Border.all(color: Colors.white, width: 7.w)),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Positioned(
                        left: 60.w,
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
                              border:
                                  Border.all(color: Colors.white, width: 7.w)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                  height: 125.h,
                                  width: 125.h,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "https://cdn.dribbble.com/userupload/16366138/file/original-c35bbf68ba08abeb0509f09de77dd62b.jpg?resize=1600x1200&vertical=center")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text("Credence Anderson",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Plumber"),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.location, size: 18.h),
                          SizedBox(width: 5.w),
                          const Text("Service Provider Past Location"),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      const Text(
                        "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.location, size: 18.h),
                          SizedBox(width: 5.w),
                          const Text("Order Location"),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      const Text(
                        "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Iconsax.location_tick),
                              SizedBox(width: 10.w),
                              const Text("Distance"),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "50 KM",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(.3)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Iconsax.wallet_2),
                              SizedBox(width: 10.w),
                              const Text("Service Fee"),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "₹ 500",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.topLeft,
              child: Text(
                "Your Review",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.3)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Johhn Batlar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Jan 11")
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.star_15,
                        size: 15.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        Iconsax.star_15,
                        size: 15.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        Iconsax.star_15,
                        size: 15.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        Iconsax.star_15,
                        size: 15.h,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        Iconsax.star_15,
                        size: 15.h,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
