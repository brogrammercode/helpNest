import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/color.dart';
import 'package:helpnest/core/utils/common_widgets.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:iconsax/iconsax.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet(
      {super.key, required this.context, required this.orderID});

  final BuildContext context;
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final order = state.orders.firstWhere((e) => e.order.id == orderID);
        final isProvider =
            order.order.providerID == FirebaseAuth.instance.currentUser?.uid;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Colors.grey.withOpacity(.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              Divider(color: Colors.grey.withOpacity(.2), height: 30.h),
              SizedBox(height: 20.h),
              Image.network(
                  (order.order.status == "Order Requested")
                      ? "https://cdn-icons-gif.flaticon.com/15370/15370728.gif"
                      : "https://cdn-icons-gif.flaticon.com/13470/13470972.gif",
                  height: 100.h),
              SizedBox(height: 20.h),
              Text(
                  order.order.status == "Order Requested"
                      ? isProvider
                          ? "Enter Estimated Fee"
                          : "Order Requested"
                      : order.order.status == "Estimated Fee Submitted"
                          ? isProvider
                              ? "Waiting for confirmation"
                              : "Place Order"
                          : "Turn on your location",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  order.order.status == "Order Requested"
                      ? isProvider
                          ? "Enter the estimated fees that you willing to charge for this service"
                          : "Your order has been requested to ${order.user.name}, Please wait for some moment. Our service partner will contact you with the fee details and terms."
                      : order.order.status == "Estimated Fee Submitted"
                          ? isProvider
                              ? "The estimation fee for this order will be ₹ ${order.order.estimatedFee}, Let's wait for the confirmation from the consumer."
                              : "The estimation fee for this order will be ₹ ${order.order.estimatedFee}, Are you sure you want to confirm the order ?"
                          : "Enable location services to get accurate recommendations and a seamless experience based on your current location.",
                  textAlign: TextAlign.center,
                ),
              ),
              if (order.order.status == "Order Requested" && isProvider) ...[
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: CustomTextFormField(
                    labelText: "Estimated Fee",
                    controller: TextEditingController(),
                    keyboardType: TextInputType.number,
                    underlineBorderedTextField: false,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 0.h),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      child: Text(
                        "Submit",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                ),
              ] else if (order.order.status == "Estimated Fee Submitted" &&
                  !isProvider) ...[
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r))),
                            child: Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ))),
                    SizedBox(width: 20.w),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r))),
                            child: Text(
                              "Confirm",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ))),
                  ],
                )
              ],
            ],
          ),
        );
      },
    );
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.clipboard_tick, size: 20.r),
            SizedBox(width: 10.w),
            const Text(
              "Order Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(CupertinoIcons.multiply, size: 20.r))
      ],
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name;
  final String role;
  final String location;
  final String date;
  final String fee;
  final String imageUrl;
  final String? buttonText;
  final IconData? buttonIcon;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onCardTapped;

  const OrderCard({
    required this.name,
    required this.role,
    required this.location,
    required this.date,
    required this.fee,
    required this.imageUrl,
    this.buttonText,
    this.buttonIcon,
    this.onButtonPressed,
    this.onCardTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTapped,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    height: 50.h,
                    width: 50.h,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (_, __) => const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(role),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Order Location",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 5.h),
            Text(location, style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn("Order Time", date, context),
                _buildInfoColumn("Order Fee", fee, context),
              ],
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: 20.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(330.r, 55.r),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r))),
                onPressed: onButtonPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (buttonIcon != null) ...[
                      Icon(buttonIcon, size: 20.sp),
                      SizedBox(width: 20.w),
                    ],
                    Text(
                      buttonText!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Column _buildInfoColumn(String title, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 5.h),
        Text(value),
      ],
    );
  }
}
