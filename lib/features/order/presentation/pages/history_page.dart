import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/order/presentation/pages/past_order.dart';
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
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderCard(
                name: "Credence Anderson",
                role: "Plumber",
                location:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
                date: "25 Dec, 2024",
                fee: "₹ 500",
                imageUrl:
                    "https://cdn.dribbble.com/users/6477965/screenshots/20111844/media/c7df4e1b8e3966abe967c8aa916eba86.jpg",
                buttonText: "Track Order",
                onButtonPressed: () {
                  // Add tracking navigation logic
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "Past Orders",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              OrderCard(
                name: "Travis Scott",
                role: "Carpenter",
                location:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
                date: "25 Dec, 2024",
                fee: "₹ 670",
                imageUrl:
                    "https://cdn.dribbble.com/users/46743/screenshots/6357861/cs19_mascot-01.jpg",
                onCardTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PastOrder()),
                  );
                },
              ),
              SizedBox(height: 20.h),
              const OrderCard(
                name: "John Lee",
                role: "Electrician",
                location:
                    "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
                date: "25 Dec, 2024",
                fee: "₹ 500",
                imageUrl:
                    "https://cdn.dribbble.com/userupload/16609994/file/original-17ddc3a453daaa783980c5529232f80a.png?resize=1600x1200&vertical=center",
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
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
              tooltip: "Notifications",
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String date;
  final String fee;
  final String imageUrl;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onCardTapped;

  const OrderCard({
    required this.name,
    required this.role,
    required this.location,
    required this.date,
    required this.fee,
    required this.imageUrl,
    this.buttonText,
    this.onButtonPressed,
    this.onCardTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTapped,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    height: 50.h,
                    width: 50.h,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (_, __) => const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(role),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Order Location",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 5.h),
            Text(location, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn("Order Time", date, context),
                _buildInfoColumn("Order Fee", fee, context),
              ],
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(330.r, 55.r),
                ),
                onPressed: onButtonPressed,
                child: Text(
                  buttonText!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Column _buildInfoColumn(String title, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 5.h),
        Text(value),
      ],
    );
  }
}
