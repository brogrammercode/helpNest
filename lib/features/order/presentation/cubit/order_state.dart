part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<GetOrderParam> orders;
  final StateStatus addOrderStatus;
  final StateStatus streamOrderStatus;
  final CommonError error;

  const OrderState({
    this.orders = const [],
    this.addOrderStatus = StateStatus.initial,
    this.streamOrderStatus = StateStatus.initial,
    this.error = const CommonError(),
  }); 

  OrderState copyWith({
    List<GetOrderParam>? orders,
    StateStatus? addOrderStatus,
    StateStatus? streamOrderStatus,
    CommonError? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      addOrderStatus: addOrderStatus ?? this.addOrderStatus,
      streamOrderStatus: streamOrderStatus ?? this.streamOrderStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [orders, addOrderStatus, streamOrderStatus, error];
}
