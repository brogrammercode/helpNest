import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class PastOrder extends StatelessWidget {
  const PastOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Credence Anderson",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            _buildProfileSection(),
            SizedBox(height: 10.h),
            const Text("Credence Anderson",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Plumber"),
            SizedBox(height: 20.h),

            // Location Details
            _buildLocationInfo(
              icon: Iconsax.location,
              title: "Service Provider Past Location",
              description:
                  "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
            ),
            _buildLocationInfo(
              icon: Iconsax.location,
              title: "Order Location",
              description:
                  "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016",
            ),

            // Service Fee and Distance Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard(
                    icon: Iconsax.location_tick,
                    title: "Distance",
                    value: "50 KM",
                  ),
                  _buildInfoCard(
                    icon: Iconsax.wallet_2,
                    title: "Service Fee",
                    value: "₹ 500",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Review Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Your Review",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _buildReviewCard(
              reviewerName: "Johhn Batlar",
              reviewDate: "Jan 11",
              rating: 5,
              reviewText:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            ),
          ],
        ),
      ),
    );
  }

  // Profile Section
  Widget _buildProfileSection() {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 150.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _buildProfileImage(
                imageUrl:
                    "https://cdn.dribbble.com/userupload/16281153/file/original-b6ff14bfc931d716c801ea7e250965ce.png?resize=1600x1200&vertical=center",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildProfileImage(
                imageUrl:
                    "https://cdn.dribbble.com/userupload/16366138/file/original-c35bbf68ba08abeb0509f09de77dd62b.jpg?resize=1600x1200&vertical=center",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage({required String imageUrl}) {
    return Container(
      alignment: Alignment.center,
      height: 125.h,
      width: 125.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10),
        ],
        border: Border.all(color: Colors.white, width: 7.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          height: 125.h,
          width: 125.h,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  // Location Details Section
  Widget _buildLocationInfo({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18.h),
                SizedBox(width: 5.w),
                Text(title),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Information Card
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon),
                SizedBox(width: 10.w),
                Text(title),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Review Section
  Widget _buildReviewCard({
    required String reviewerName,
    required String reviewDate,
    required int rating,
    required String reviewText,
  }) {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviewerName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(reviewDate),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(
              rating,
              (index) => Icon(
                Iconsax.star_15,
                size: 15.h,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(reviewText),
        ],
      ),
    );
  }
}
