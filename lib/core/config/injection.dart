import 'package:get_it/get_it.dart';
import 'package:helpnest/features/auth/data/data_source/auth_remote_ds.dart';
import 'package:helpnest/features/auth/domain/repo/auth_repo.dart';
import 'package:helpnest/features/auth/presentation/cubit/auth_state.dart';

class Injections {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> init() async {
    // auth
    _getIt.registerFactory<AuthRepo>(() => AuthRemoteDs());
    _getIt.registerFactory<AuthCubit>(() => AuthCubit(repo: _getIt()));
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
