import 'package:helpnest/features/profile/data/models/service_provier_model.dart';

abstract class ServiceProviderRepo {
  Future<List<ServiceProviderModel>> getServiceProviders();
  Future<void> addServiceProviders({required ServiceProviderModel provider});
}
