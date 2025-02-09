import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:helpnest/features/order/presentation/pages/track_page.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        log("ORDER_COUNT: ${state.orders.length}");
        final activeOrders = state.orders
            .where((e) => e.order.status != "Order Completed")
            .toList()
          ..sort((a, b) => b.order.orderTD.compareTo(a.order.orderTD));

        final pastOrders = state.orders
            .where((e) => e.order.status == "Order Completed")
            .toList()
          ..sort((a, b) => b.order.orderTD.compareTo(a.order.orderTD));

        return Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activeOrders.length,
                      itemBuilder: (context, i) {
                        final order = activeOrders[i];
                        final service = context
                            .read<ServiceCubit>()
                            .state
                            .services
                            .where((a) => a.id == order.order.serviceID)
                            .toList()
                            .first;
                        final location = order.order.consumerLocation;
                        return OrderCard(
                          name: order.user.name,
                          role: service.name,
                          location:
                              "${location.area}, ${location.city}, ${location.state}, ${location.country} Pin - ${location.pincode}",
                          date: DateFormat("dd MMM, yyyy")
                              .format(order.order.orderTD.toDate()),
                          fee: "₹ 500",
                          imageUrl:
                             order.user.image,
                          buttonText: "Track Order",
                          onButtonPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        TrackPage(orderID: order.order.id)));
                          },
                        );
                      }),
                  if (pastOrders.isNotEmpty) ...[
                    Text(
                      "Past Orders",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pastOrders.length,
                        itemBuilder: (context, i) {
                          final order = activeOrders[i];
                          final service = context
                              .read<ServiceCubit>()
                              .state
                              .services
                              .where((a) => a.id == order.order.serviceID)
                              .toList()
                              .first;
                          final location = order.order.consumerLocation;
                          return OrderCard(
                            name: order.user.name,
                            role: service.name,
                            location:
                                "${location.area}, ${location.city}, ${location.state}, ${location.country} Pin - ${location.pincode}",
                            date: DateFormat("dd MMM, yyyy")
                                .format(order.order.orderTD.toDate()),
                            fee: "₹ 500",
                            imageUrl: order.user.image,
                            onButtonPressed: () {
                              // Add tracking navigation logic
                            },
                          );
                        }),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: AppBar(
          title: Text(
            "Order History",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
              tooltip: "Notifications",
            ),
          ],
        ),
      ),
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
                        borderRadius: BorderRadius.circular(10.r))
                ),
                onPressed: onButtonPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.location, size: 20.sp),
                    SizedBox(width: 20.w),
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
