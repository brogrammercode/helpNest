import 'package:helpnest/features/auth/data/models/user_model.dart';

abstract class UserRepo {
  Stream<UserModel> getUserModelStream();
}
