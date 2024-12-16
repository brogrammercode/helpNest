import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/auth/presentation/pages/otp_page.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically request focus when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // Dispose of the FocusNode to avoid memory leaks
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Log In With Phone",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Quickly access your HelpNest account with your phone number for a secure and hassle-free login experience.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  keyboardType: TextInputType.number,
                  focusNode: _phoneFocusNode, // Attach the FocusNode
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      prefixText: "+91 ",
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0)))),
                )
              ],
            ),
          ),
          Expanded(child: SizedBox(height: 1.h)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const OtpPage()));
              },
              child: Text(
                "Continue",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
