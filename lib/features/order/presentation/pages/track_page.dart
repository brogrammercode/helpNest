import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpnest/core/utils/common_methods.dart';
import 'package:helpnest/features/order/presentation/cubit/order_cubit.dart';

class TrackPage extends StatefulWidget {
  final String orderID;
  const TrackPage({super.key, required this.orderID});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final order = state.orders
            .firstWhere((order) => order.order.id == widget.orderID)
            .order;
        final provider = state.orders
            .firstWhere((order) => order.order.id == widget.orderID)
            .user;
        return Scaffold(
          appBar: AppBar(),
          body: Image.network(
              mapImage(points: [
                const GeoPoint(28.5251773, 77.1882187),
                const GeoPoint(28.5250963, 77.1883052),
                const GeoPoint(28.5247115, 77.1881633),
                const GeoPoint(28.5247115, 77.1881633),
              ]),
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height,
              width: double.infinity),
        );
      },
    );
  }
}
