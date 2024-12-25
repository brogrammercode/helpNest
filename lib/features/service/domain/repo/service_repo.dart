import 'package:helpnest/features/service/data/models/service_model.dart';

abstract class ServiceRepo {
  Future<List<ServiceModel>> getServices();
  Future<void> addService({required ServiceModel service});
}
