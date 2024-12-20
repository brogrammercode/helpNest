import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/utils/common_widgets.dart';

class BecomeProviderPage extends StatefulWidget {
  const BecomeProviderPage({super.key});

  @override
  State<BecomeProviderPage> createState() => _BecomeProviderPageState();
}

class _BecomeProviderPageState extends State<BecomeProviderPage> {
  final TextEditingController serviceController = TextEditingController();
  String selectedService = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Become a Service Provider",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: ElevatedButton(
          onPressed: () {
            // Handle verification request
          },
          child: Text(
            "Request Verification",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "Select Service",
                controller: serviceController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
