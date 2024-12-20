import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/profile/presentation/pages/about_page.dart';
import 'package:helpnest/features/profile/presentation/pages/become_provider_page.dart';
import 'package:helpnest/features/profile/presentation/pages/privacy_policy.dart';
import 'package:helpnest/features/profile/presentation/pages/send_feedback_page.dart';
import 'package:helpnest/features/profile/presentation/pages/support_page.dart';
import 'package:helpnest/features/profile/presentation/pages/terms_condition.dart';
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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(context),
            SizedBox(height: 30.h),
            _buildListTile(
              icon: Iconsax.frame_1,
              title: "Your Profile",
              onTap: () {}, // Add navigation logic
            ),
            _buildListTile(
              icon: Iconsax.briefcase,
              title: "Become a Service Provider",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BecomeProviderPage()),
              ),
            ),
            _buildListTile(
              icon: Iconsax.info_circle,
              title: "Report a Safety Emergency",
              onTap: () {}, // Add navigation logic
            ),
            _buildListTile(
              icon: Iconsax.support,
              title: "Support",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SupportPage()),
              ),
            ),
            _buildListTile(
              icon: Iconsax.edit_2,
              title: "Send Feedback",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SendFeedbackPage()),
              ), 
            ),
            _buildListTile(
              icon: Iconsax.more_circle,
              title: "About",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              ), 
            ),
            _buildListTile(
              icon: Iconsax.shield_tick,
              title: "Privacy Policy",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicy()),
              ),
            ),
            _buildListTile(
              icon: Iconsax.receipt_1,
              title: "Terms and Conditions",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsCondition()),
              ),
            ),
            _buildListTile(
              icon: Iconsax.unlock,
              title: "Log out",
              onTap: () {}, // Add logout logic
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
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

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 135.h,
            width: 135.h,
            margin: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
              border: Border.all(color: Colors.white, width: 7.w),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                height: 125.h,
                width: 125.h,
                fit: BoxFit.cover,
                imageUrl:
                    "https://cdn.dribbble.com/userupload/16281153/file/original-b6ff14bfc931d716c801ea7e250965ce.png?resize=1600x1200&vertical=center",
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Credence Anderson",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 24.w),
                SizedBox(width: 20.w),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Iconsax.arrow_right_3, size: 24.w),
          ],
        ),
      ),
    );
  }
}
