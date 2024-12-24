import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/search/presentation/pages/provider_profile.dart';

class ServiceProviderList extends StatefulWidget {
  final String category;

  const ServiceProviderList({super.key, required this.category});

  @override
  State<ServiceProviderList> createState() => _ServiceProviderListState();
}

class _ServiceProviderListState extends State<ServiceProviderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category, // Dynamic title based on the category
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHorizontalScroll(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: const Text(
                "A plumber is a skilled tradesperson who specializes in the installation, maintenance, and repair of pipes, fixtures, and appliances used to distribute water, gas, and waste in residential, commercial, and industrial settings.",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            _buildSection(
              title: "Service Provider Near You",
              itemCount: 5,
              itemBuilder: (context, index) => _buildPersonTile(index != 4),
            ),
            SizedBox(height: 20.h),
            _buildSection(
              title: "Top Plumbers",
              itemCount: 3,
              itemBuilder: (context, index) => _buildPersonTile(index != 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }

  Widget _buildPersonTile(bool showDivider) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProviderProfile(),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildProfileImage(
                "https://cdn.dribbble.com/users/6477965/screenshots/20111844/media/c7df4e1b8e3966abe967c8aa916eba86.jpg",
              ),
              SizedBox(width: 10.w),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Credence Anderson",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Plumber\t\t\t\t\t4.7 ★"),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\u20b9 500",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const Text(
                    "5.6 Km",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20.h),
          const Text("Last Location",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5.h),
          const Text(
              "Akshya Nagar 1st Block 1st Cross, Rammurthy nagar, Bangalore-560016"),
          if (showDivider) ...[
            SizedBox(height: 20.h),
            Divider(color: Colors.grey.withOpacity(.3)),
          ],
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildProfileImage(String imageUrl) {
    return ClipOval(
      child: CachedNetworkImage(
        height: 50.h,
        width: 50.h,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
      ),
    );
  }

  Widget _buildHorizontalScroll() {
    final List<String> imageUrls = [
      "https://cdn.dribbble.com/userupload/16836268/file/original-e8e0c80d5364357af82908db651475e0.png?resize=1024x1025&vertical=center",
      "https://cdn.dribbble.com/userupload/17223940/file/original-bc2bebdff2f7f6d38fecbd0046559099.png?resize=1600x1200&vertical=center",
      // Add more URLs as needed
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 20.w),
          ...imageUrls.map((url) => _buildPopularItem(url)),
        ],
      ),
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
          errorWidget: (context, url, error) => SizedBox(
            height: 250.h,
            width: 350.w,
            child: Center(child: Icon(Icons.error, size: 50.w)),
          ),
        ),
      ),
    );
  }
}