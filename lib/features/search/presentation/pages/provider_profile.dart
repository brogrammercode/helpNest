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
          style: ElevatedButton.styleFrom(
            fixedSize: Size(330.r, 55.r),
          ),
          onPressed: () {},
          child: Text(
            "Order Service",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileImages(),
            SizedBox(height: 10.h),
            const Text("Credence Anderson",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Plumber"),
            SizedBox(height: 10.h),
            _buildRatingRow(false),
            SizedBox(height: 30.h),
            _buildDetailsSection(context),
            _buildLocationSection(),
            _buildReviewsSection(context),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImages() {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 150.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _buildCircularImage(
                "https://cdn.dribbble.com/userupload/16281153/file/original-b6ff14bfc931d716c801ea7e250965ce.png?resize=1600x1200&vertical=center",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildCircularImage(
                "https://cdn.dribbble.com/userupload/16366138/file/original-c35bbf68ba08abeb0509f09de77dd62b.jpg?resize=1600x1200&vertical=center",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularImage(String imageUrl) {
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

  Widget _buildRatingRow(bool small) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildStarIcon(small)),
    );
  }

  Widget _buildStarIcon(bool small) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Icon(
        Iconsax.star_15,
        size: small ? 15.h : null,
        color: small ? Theme.of(context).primaryColor : Colors.orange,
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailCard(
            context,
            icon: Iconsax.briefcase,
            title: "Experience",
            value: "5000+",
          ),
          SizedBox(width: 20.w),
          _buildDetailCard(
            context,
            icon: Iconsax.wallet_2,
            title: "Service Fee",
            value: "\u20b9 500",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context,
      {required IconData icon, required String title, required String value}) {
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
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
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
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context) {
    return Padding(
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
              return _buildReviewCard(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
      ),
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
              Text("Jan 11"),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(5, (index) => _buildStarIcon(true)),
          ),
          SizedBox(height: 10.h),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make.",
          ),
        ],
      ),
    );
  }
}
