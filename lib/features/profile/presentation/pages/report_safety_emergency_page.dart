import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';
import 'package:iconsax/iconsax.dart';

class ReportSafetyEmergencyPage extends StatefulWidget {
  const ReportSafetyEmergencyPage({super.key});

  @override
  State<ReportSafetyEmergencyPage> createState() =>
      _ReportSafetyEmergencyPageState();
}

class _ReportSafetyEmergencyPageState extends State<ReportSafetyEmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: _submitButton(context, state),
          body: Column(
            children: [
              _reportBox(context),
              _callNowBox(context),
            ],
          ),
        );
      },
    );
  }

  Container _callNowBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Admin Response",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 5.h),
          Text(
            "Your request has been received. Our emergency team is reaching out to you. Please keep your phone on and stay attentive to incoming calls.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.call, color: Colors.white),
                  SizedBox(width: 20.w),
                  Text(
                    "Call Now",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _reportBox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.flag, color: Colors.white, size: 17.r),
              SizedBox(width: 5.w),
              Expanded(
                  child: Text(
                "Emergency Needed",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              ))
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "Report a Safety Emergency",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20.h),
          LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: .8,
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "50%",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              Text(
                "Wait for the response",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "If you witness a safety emergency, report it immediately to the relevant authorities or emergency services. Providing timely and accurate details can help ensure a swift response and protect those involved.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white),
              child: Text(
                "Report Emergency",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
              ))
        ],
      ),
    );
  }

  // ignore: unused_element
  Padding _submitButton(BuildContext context, ProfileState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Resolve",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            if (state.reportSafetyEmergencyStatus == StateStatus.loading) ...[
              SizedBox(width: 30.w),
              SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            ],
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Report a Safety Emergency",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
