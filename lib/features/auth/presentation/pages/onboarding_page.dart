import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/auth/presentation/pages/phone_input_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<List<String>> onboarding = [
    [
      "Find Services\nwith Ease",
      "Browse and connect with trusted service providers tailored to your needs."
    ],
    [
      "Seamless\nCommunication",
      "Chat directly with service providers to discuss and finalize your requirements."
    ],
    [
      "Quality\nYou Can Trust",
      "Experience verified professionals delivering top-notch service, every time."
    ]
  ];
  bool skipped = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          SizedBox(height: 50.h),
          Center(
            child: Text(
              onboarding[0][0],
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: SizedBox(height: 350.h)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              onboarding[0][1],
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50.h),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PhoneInputPage()),
              );
            },
            child: Text(
              skipped ? "Log in with Phone" : "Continue",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 70.h),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(context, active: false),
          SizedBox(width: 7.w),
          _buildIndicator(context, active: true, width: 30.w),
          SizedBox(width: 7.w),
          _buildIndicator(context, active: false),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Skip",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        )
      ],
    );
  }

  Widget _buildIndicator(BuildContext context,
      {required bool active, double width = 7.0}) {
    return Container(
      height: 7.h,
      width: width.h,
      decoration: BoxDecoration(
        color: active
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
