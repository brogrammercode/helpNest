import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Order Service",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            SizedBox(height: 10.h),
            const Text("Credence Anderson",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Plumber"),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.star_15,
                  color: Colors.orange,
                ),
                SizedBox(width: 5.w),
                const Icon(
                  Iconsax.star_15,
                  color: Colors.orange,
                ),
                SizedBox(width: 5.w),
                const Icon(
                  Iconsax.star_15,
                  color: Colors.orange,
                ),
                SizedBox(width: 5.w),
                const Icon(
                  Iconsax.star_15,
                  color: Colors.orange,
                ),
                SizedBox(width: 5.w),
                const Icon(
                  Iconsax.star_15,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              const Icon(Iconsax.briefcase),
                              SizedBox(width: 10.w),
                              const Text("Experience"),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "5000+",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.location, size: 18.h),
                          SizedBox(width: 5.w),
                          const Text("Current Location"),
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
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Reviews - 100+"),
                  SizedBox(height: 20.h),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.3)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Johhn Batlar",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                        );
                      })
                ],
              ),
            ),
            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }
}
