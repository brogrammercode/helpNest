import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/service/presentation/pages/service_provider_list.dart';
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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(),
            _buildServiceGrid(),
            _buildSectionTitle(context, "Popular"),
            _buildHorizontalScroll(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  /// Builds the custom app bar.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: _buildIconButton(Iconsax.menu_1, () {}),
          title: Text(
            "helpNest",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            _buildIconButton(Iconsax.location, () {}),
            _buildIconButton(Iconsax.notification, () {}),
          ],
        ),
      ),
    );
  }

  /// Builds a reusable circular icon button.
  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
      ),
    );
  }

  /// Builds the main header image.
  Widget _buildHeaderImage() {
    return CachedNetworkImage(
      imageUrl:
          "https://cdn.dribbble.com/userupload/11053099/file/original-e98e2d290e832cf1bc654e5eb86be778.png?resize=1600x1200&vertical=center",
      placeholder: (context, url) => SizedBox(
        height: 200.h,
        child: const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        )),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error, size: 50.w),
    );
  }

  /// Builds the grid of services.
  Widget _buildServiceGrid() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return _buildServiceItem("Plumber",
            "https://cdn.dribbble.com/userupload/16782566/file/original-a1e8dab093cbde95aa248729ef505ae8.png?resize=1200x900&vertical=center",
            () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ServiceProviderList(
                        category: 'Plumber',
                      )));
        });
      },
    );
  }

  /// Builds an individual service item for the grid.
  Widget _buildServiceItem(
      String title, String imageUrl, Function() onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              height: 60.h,
              width: 60.h,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) => SizedBox(
                height: 60.h,
                width: 60.h,
                child: const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
              ),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, size: 40.w),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Builds the title for a section.
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 10.h),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Builds the horizontal scroll view for popular items.
  Widget _buildHorizontalScroll() {
    final List<String> imageUrls = [
      "https://cdn.dribbble.com/userupload/16836268/file/original-e8e0c80d5364357af82908db651475e0.png?resize=1024x1025&vertical=center",
      "https://cdn.dribbble.com/userupload/17223940/file/original-bc2bebdff2f7f6d38fecbd0046559099.png?resize=1600x1200&vertical=center",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 20.w),
          ...imageUrls.map((url) => _buildPopularItem(url)),
          SizedBox(width: 20.w),
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
          errorWidget: (context, url, error) => Icon(Icons.error, size: 50.w),
        ),
      ),
    );
  }
}
