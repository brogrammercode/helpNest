import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';
import 'package:helpnest/features/profile/domain/repo/profile_repo.dart';

class ProfileRemoteDs implements ServiceProviderRepo {
  @override
  Future<void> addFeedback({required FeedbackModel feedback}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<FeedbackModel>> getAppFeedback() {
    throw UnimplementedError();
  }

  @override
  Stream<ServiceProviderModel> getProvider() {
    throw UnimplementedError();
  }

  @override
  Stream<UserModel> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> reportSafetyEmergency() {
    throw UnimplementedError();
  }

  @override
  Future<void> requestServiceProviderAccess(
      {required ServiceProviderModel provider}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProvider({required ServiceProviderModel provider}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required UserModel user}) {
    throw UnimplementedError();
  }
}
