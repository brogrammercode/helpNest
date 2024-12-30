import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';

abstract class ServiceProviderRepo {
  Future<void> requestServiceProviderAccess(
      {required ServiceProviderModel provider});
  Stream<UserModel> getUser();
  Stream<ServiceProviderModel> getProvider();
  Stream<List<FeedbackModel>> getAppFeedback();
  Future<void> addFeedback({required FeedbackModel feedback});
  Future<void> reportSafetyEmergency();
  Future<void> updateUser({required UserModel user});
  Future<void> updateProvider({required ServiceProviderModel provider});
}
