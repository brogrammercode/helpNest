import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:helpnest/features/order/presentation/pages/track_page.dart';
import 'package:helpnest/features/order/presentation/widgets/history_widgets.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool providerOrders = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        log("ORDER_COUNT: ${state.orders.length}");
        final activeOrders = state.orders
            .where((e) =>
                (e.order.status != "Order Completed" &&
                    e.order.status != "Order Cancelled") &&
                (providerOrders
                    ? e.order.providerID ==
                        FirebaseAuth.instance.currentUser?.uid
                    : e.order.consumerID ==
                        FirebaseAuth.instance.currentUser?.uid))
            .toList()
          ..sort((a, b) => b.order.orderTD.compareTo(a.order.orderTD));

        final pastOrders = state.orders
            .where((e) =>
                (e.order.status == "Order Completed" ||
                    e.order.status == "Order Cancelled") &&
                (providerOrders
                    ? e.order.providerID ==
                        FirebaseAuth.instance.currentUser?.uid
                    : e.order.consumerID ==
                        FirebaseAuth.instance.currentUser?.uid))
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
                          name: providerOrders
                              ? order.consumer.name
                              : order.user.name,
                          role: providerOrders ? "Consumer" : service.name,
                          location:
                              "${location.area}, ${location.city}, ${location.state}, ${location.country} Pin - ${location.pincode}",
                          date: DateFormat("dd MMM, yyyy")
                              .format(order.order.orderTD.toDate()),
                          fee:
                              "₹ ${order.order.orderFee != 0 ? order.order.orderFee : order.order.estimatedFee != 0 ? order.order.estimatedFee : "N/A"}",
                          imageUrl: providerOrders
                              ? order.consumer.image
                              : order.user.image,
                          buttonText: order.order.status == "Order Requested"
                              ? "Order Requested"
                              : order.order.status == "Estimated Fee Submitted"
                                  ? "Order at ₹ ${order.order.estimatedFee}"
                                  : order.order.status == "Order Placed"
                                      ? "Track Order"
                                      : "Track Order",
                          buttonIcon: order.order.status == "Order Requested"
                              ? Iconsax.cloud_add
                              : order.order.status == "Order Placed"
                                  ? Iconsax.gps
                                  : null,
                          onButtonPressed:
                              (order.order.status != "Order Placed" &&
                                      order.order.status != "On the Way")
                                  ? () {
                                      showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Colors.transparent,
                                          isDismissible: false,
                                          isScrollControlled: true,
                                          builder: (_) => OrderBottomSheet(
                                                context: context,
                                                orderID: order.order.id,
                                              ));
                                    }
                                  : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => TrackPage(
                                                  orderID: order.order.id)));
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
                          final order = pastOrders[i];
                          final service = context
                              .read<ServiceCubit>()
                              .state
                              .services
                              .where((a) => a.id == order.order.serviceID)
                              .toList()
                              .first;
                          final location = order.order.consumerLocation;
                          return OrderCard(
                            name: providerOrders
                                ? order.consumer.name
                                : order.user.name,
                            role: providerOrders ? "Consumer" : service.name,
                            location:
                                "${location.area}, ${location.city}, ${location.state}, ${location.country} Pin - ${location.pincode}",
                            date: DateFormat("dd MMM, yyyy")
                                .format(order.order.orderTD.toDate()),
                            fee:
                                "₹ ${order.order.orderFee != 0 ? order.order.orderFee : order.order.estimatedFee != 0 ? order.order.estimatedFee : "N/A"}",
                            imageUrl: providerOrders
                                ? order.consumer.image
                                : order.user.image,
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
            providerOrders ? "Assigned Orders" : "Order History",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () => setState(() => providerOrders = !providerOrders),
              icon: const Icon(Iconsax.arrow_2),
              tooltip: "Switch Orders",
            ),
          ],
        ),
      ),
    );
  }
}
