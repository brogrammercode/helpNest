import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/history/presentation/pages/past_order.dart';
import 'package:iconsax/iconsax.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                              height: 50.h,
                              width: 50.h,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://cdn.dribbble.com/users/6477965/screenshots/20111844/media/c7df4e1b8e3966abe967c8aa916eba86.jpg"),
                        ),
                        SizedBox(width: 10.w),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Credence Anderson",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Plumber"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Order Location",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    const Text(
                        "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016"),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            const Text("25 Dec, 2024")
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Fee",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            const Text("₹ 500")
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Track Order",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Past Orders",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PastOrder()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                                height: 50.h,
                                width: 50.h,
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://cdn.dribbble.com/users/46743/screenshots/6357861/cs19_mascot-01.jpg"),
                          ),
                          SizedBox(width: 10.w),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Travis Scott",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Carpenter"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Order Location",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.h),
                      const Text(
                          "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016"),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Time",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.h),
                              const Text("25 Dec, 2024")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.h),
                              const Text("₹ 670")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                              height: 50.h,
                              width: 50.h,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://cdn.dribbble.com/userupload/16609994/file/original-17ddc3a453daaa783980c5529232f80a.png?resize=1600x1200&vertical=center"),
                        ),
                        SizedBox(width: 10.w),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Lee",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Electrician"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Order Location",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    const Text(
                        "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016"),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            const Text("25 Dec, 2024")
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Fee",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            const Text("₹ 500")
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            "Order History",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
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
