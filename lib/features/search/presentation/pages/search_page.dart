import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/search/presentation/pages/provider_profile.dart';
import 'package:iconsax/iconsax.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context),
            _buildSection(
              title: "People",
              itemCount: 5,
              itemBuilder: (context, index) => _buildPersonTile(),
            ),
            _buildSection(
              title: "Services",
              itemCount: 5,
              itemBuilder: (context, index) => _buildServiceTile(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(
            "Search",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5.w),
          AnimatedTextKit(
            animatedTexts: [
              _buildAnimatedText("Services"),
              _buildAnimatedText("Service Provider"),
              _buildAnimatedText("Price"),
            ],
            repeatForever: true,
          ),
        ],
      ),
    );
  }

  FadeAnimatedText _buildAnimatedText(String text) {
    return FadeAnimatedText(
      text,
      textStyle: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.bold),
      duration: const Duration(seconds: 3),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w500),
        maxLines: null,
        decoration: InputDecoration(
          prefixIcon: const Icon(Iconsax.search_normal_1),
          filled: true,
          hintText: "Search for anything",
          fillColor: Colors.grey.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
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

  Widget _buildPersonTile() {
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Credence Anderson",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Plumber"),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildServiceTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildProfileImage(
              "https://cdn.dribbble.com/userupload/16281153/file/original-b6ff14bfc931d716c801ea7e250965ce.png?resize=1600x1200&vertical=center",
            ),
            SizedBox(width: 10.w),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plumber",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("1000+ service provided"),
              ],
            ),
          ],
        ),
        SizedBox(height: 15.h),
      ],
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
}
