import 'package:helpnest/features/auth/data/models/user_model.dart';

abstract class HomeRemoteRepo {
  Future<UserLocationModel?> getLocationFromDatabase();
  Future<void> updateLocationToDatabase({required UserLocationModel location});
}
