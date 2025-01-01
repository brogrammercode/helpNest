part of 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final ServiceRepo _repo;

  ServiceCubit({required ServiceRepo repo})
      : _repo = repo,
        super(const ServiceState());

  Future<void> getServices() async {
    try {
      emit(state.copyWith(getServicesStatus: StateStatus.loading));
      final services = await _repo.getServices();
      emit(state.copyWith(
          services: services, getServicesStatus: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          getServicesStatus: StateStatus.failure,
          error: CommonError(consoleMessage: e.toString())));
    }
  }

  Future<void> findServiceProviders({required String serviceID}) async {
    try {
      emit(state.copyWith(findServiceProvidersStatus: StateStatus.loading));
      final serviceProviders =
          await _repo.findServiceProvider(serviceID: serviceID);
      emit(state.copyWith(
          serviceProviders: serviceProviders,
          findServiceProvidersStatus: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          findServiceProvidersStatus: StateStatus.failure,
          error: CommonError(consoleMessage: e.toString())));
    }
  }

  Future<void> addOrder({required OrderModel order}) async {
    try {
      emit(state.copyWith(addOrderStatus: StateStatus.loading));
      await _repo.addOrder(order: order);
      emit(state.copyWith(addOrderStatus: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          addOrderStatus: StateStatus.failure,
          error: CommonError(consoleMessage: e.toString())));
    }
  }
}
