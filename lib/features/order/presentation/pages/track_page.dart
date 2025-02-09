// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackPage extends StatefulWidget {
  final String orderID;
  const TrackPage({super.key, required this.orderID});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  MapController _mapController = MapController();
  bool _appBarExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final orderData = state.orders
            .firstWhere((order) => order.order.id == widget.orderID);
        final order = orderData.order;
        final provider = orderData.user;
        final service = context
            .read<ServiceCubit>()
            .state
            .services
            .firstWhere((service) => service.id == order.serviceID);
        final me = context.read<ProfileCubit>().state.user.first;

        return Scaffold(
          
          floatingActionButton: _bottomBar(
              context: context,
              provider: provider,
              service: service,
              order: order),
          floatingActionButtonAnimator:
              FloatingActionButtonAnimator.noAnimation,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Stack(
            children: [
              _map(order, provider, me),
              Positioned(
                  top: 30.h,
                  left: 0,
                  right: 0,
                  child: _appBar(
                      context: context, provider: provider, service: service))
            ],
          ),
        );
      },
    );
  }

  FlutterMap _map(OrderModel order, UserModel provider, UserModel me) {
    final LatLng consumerLatLng = LatLng(
        order.consumerLocation.geopoint.latitude,
        order.consumerLocation.geopoint.longitude);

    final LatLng providerLatLng = LatLng(provider.location.geopoint.latitude,
        provider.location.geopoint.longitude);

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds.fromPoints([consumerLatLng, providerLatLng]),
          padding: EdgeInsets.all(50.r),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.helpnest",
        ),
        MarkerLayer(
          markers: [
            _marker(consumerLatLng, me),
            _marker(providerLatLng, provider),
          ],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: [consumerLatLng, providerLatLng],
              color: Colors.grey.withOpacity(.2),
              strokeWidth: 3.0,
            ),
          ],
        ),
      ],
    );
  }

  Container _appBar(
      {required BuildContext context,
      required UserModel provider,
      required ServiceModel service}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: _appBarExpanded ? 20.w : 10.h,
          top: 10.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildProfileImages(
                        providerImage: provider.image,
                        serviceImage: service.logo),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${service.name} Service",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildIconButton(
                  icon: _appBarExpanded
                      ? Iconsax.arrow_up_2
                      : Iconsax.arrow_down_1,
                  onPressed: () =>
                      setState(() => _appBarExpanded = !_appBarExpanded)),
            ],
          ),
          if (_appBarExpanded) ...[
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call, color: Colors.white, size: 20.r),
                        SizedBox(width: 10.w),
                        Text(
                          "Call",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.red,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, color: Colors.white, size: 20.r),
                        SizedBox(width: 10.w),
                        Text(
                          "Cancel Order",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ],
      ),
    );
  }

  Container _bottomBar(
      {required BuildContext context,
      required UserModel provider,
      required ServiceModel service,
      required OrderModel order}) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(30.r)),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 14.r),
                    SizedBox(width: 10.w),
                    Text(
                      "On the way to your location",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Text("117 KM",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 15.h),
          TimelineTile(
            axis: TimelineAxis.vertical,
            alignment: TimelineAlign.start,
            isFirst: true,
            indicatorStyle: IndicatorStyle(width: 15.r),
            afterLineStyle:
                LineStyle(thickness: 1, color: Colors.grey.withOpacity(.3)),
            endChild: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Provider Location",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "${provider.location.area}, ${provider.location.city}, ${provider.location.state}, ${provider.location.country} Pin - ${provider.location.pincode}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          TimelineTile(
            axis: TimelineAxis.vertical,
            alignment: TimelineAlign.start,
            isLast: true,
            indicatorStyle: IndicatorStyle(width: 15.r),
            beforeLineStyle:
                LineStyle(thickness: 1, color: Colors.grey.withOpacity(.3)),
            endChild: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Location",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    "${order.consumerLocation.area}, ${order.consumerLocation.city}, ${order.consumerLocation.state}, ${order.consumerLocation.country} Pin - ${order.consumerLocation.pincode}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImages(
      {required String providerImage, required String serviceImage}) {
    return Center(
      child: SizedBox(
        width: 90.w,
        height: 60.h,
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
      height: 50.h,
      width: 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 10),
        ],
        border: Border.all(color: Colors.white, width: 4.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(padded ? 5.r : 0),
          child: CachedNetworkImage(
            height: 50.h,
            width: 50.h,
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

  _marker(LatLng consumerLocation, UserModel provider) {
    return Marker(
      point: consumerLocation,
      width: 70.r,
      height: 70.r,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20.r,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Icon(Iconsax.location5, color: Colors.white, size: 70.r),
            Positioned(
              top: 5.r,
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(4.w),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(provider.image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildIconButton(
      {required IconData icon, required void Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
      ),
    );
  }
}
