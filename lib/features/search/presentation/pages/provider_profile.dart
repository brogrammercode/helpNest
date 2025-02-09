// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/home/presentation/cubit/home_cubit.dart';
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';
import 'package:helpnest/features/service/domain/repo/service_remote_repo.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ProviderProfile extends StatefulWidget {
  final FindServiceProviderParams provider;
  const ProviderProfile({super.key, required this.provider});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  ServiceModel? service;
  num avgRating = 5;

  @override
  void initState() {
    service = context
        .read<ServiceCubit>()
        .state
        .services
        .firstWhere((e) => e.id == widget.provider.serviceProvider.serviceID);
    if (widget.provider.feedbacks.isNotEmpty) {
      double totalRating = widget.provider.feedbacks
          .fold(0, (sum, feedback) => sum + feedback.rating);
      avgRating = totalRating / widget.provider.feedbacks.length;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: _order(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileImages(
                providerImage: widget.provider.user.image,
                serviceImage: service?.logo ?? ""),
            SizedBox(height: 10.h),
            Text(widget.provider.user.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(service?.name ?? "Service"),
            SizedBox(height: 10.h),
            _buildRatingRow(false),
            SizedBox(height: 30.h),
            _buildDetailsSection(context),
            _buildLocationSection(location: widget.provider.user.location),
            _buildReviewsSection(
                context: context, feedbacks: widget.provider.feedbacks),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Padding _order(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(330.r, 55.r),
            ),
            onPressed: state.addOrderStatus == StateStatus.loading
                ? () {}
                : () async {
                    final td = Timestamp.now();
                    final UserLocationModel? lastLocation = context
                            .read<HomeCubit>()
                            .state
                            .lastLocation
                            .isEmpty
                        ? null
                        : context.read<HomeCubit>().state.lastLocation.first;
                    final result = await context.read<OrderCubit>().addOrder(
                            order: OrderModel(
                          id: td.millisecondsSinceEpoch.toString(),
                          consumerID:
                              FirebaseAuth.instance.currentUser?.uid ?? "",
                          providerID: widget.provider.user.id,
                          serviceID: service?.id ?? "",
                          orderTD: td,
                          completionTD: td,
                          consumerLocation: lastLocation ??
                              UserLocationModel(
                                  city: "city",
                                  area: "area",
                                  pincode: "pincode",
                                  locality: "locality",
                                  state: "state",
                                  country: "country",
                                  continent: "continent",
                                  geopoint: const GeoPoint(0, 0),
                                  updateTD: td),
                          providerLocation: widget.provider.user.location,
                          orderFee: 0,
                          estimatedFee: 0,
                          trackingPolylinePoints: [],
                          creationTD: td,
                          createdBy:
                              FirebaseAuth.instance.currentUser?.uid ?? "",
                          deactivate: false,
                          status: "Order Requested",
                        ));

                    if (result) {
                      if (mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        context
                            .read<HomeCubit>()
                            .updateBottomNavIndex(index: 3);
                      }
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order Service",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (state.addOrderStatus == StateStatus.loading) ...[
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
          );
        },
      ),
    );
  }

  Widget _buildProfileImages(
      {required String providerImage, required String serviceImage}) {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 150.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _buildCircularImage(imageUrl: serviceImage, padded: true),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildCircularImage(imageUrl: providerImage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularImage({required String imageUrl, bool padded = false}) {
    return Container(
      alignment: Alignment.center,
      height: 125.h,
      width: 125.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10),
        ],
        border: Border.all(color: Colors.white, width: 7.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(padded ? 20.r : 0),
          child: CachedNetworkImage(
            height: 125.h,
            width: 125.h,
            fit: BoxFit.cover,
            errorWidget: (c, u, e) {
              return const Icon(Iconsax.gallery);
            },
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(bool small) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => _buildStarIcon(small)),
    );
  }

  Widget _buildStarIcon(bool small) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Icon(
        Iconsax.star_15,
        size: small ? 15.h : null,
        color: small ? Theme.of(context).primaryColor : Colors.orange,
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailCard(
            context,
            icon: Iconsax.briefcase,
            title: "Experience",
            value: "5000+",
          ),
          SizedBox(width: 20.w),
          _buildDetailCard(
            context,
            icon: Iconsax.wallet_2,
            title: "Service Fee",
            value: "\u20b9 500",
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context,
      {required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon),
                SizedBox(width: 10.w),
                Text(title),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection({required UserLocationModel location}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.location, size: 18.h),
              SizedBox(width: 5.w),
              const Text("Current Location"),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "${location.area}, ${location.city}, ${location.state}, ${location.country} Pin - ${location.pincode}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(
      {required BuildContext context, required List<FeedbackModel> feedbacks}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(feedbacks.isNotEmpty ? "Reviews - ${feedbacks.length}+" : ""),
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: feedbacks.length,
            itemBuilder: (context, index) {
              return _buildReviewCard(
                  context: context, feedback: feedbacks[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
      {required BuildContext context, required FeedbackModel feedback}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                feedback.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(DateFormat("mmm dd").format(feedback.creationTD.toDate())),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(
                feedback.rating.toInt(), (index) => _buildStarIcon(true)),
          ),
          SizedBox(height: 10.h),
          Text(
            feedback.description,
          ),
        ],
      ),
    );
  }
}
