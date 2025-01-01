import 'package:get_it/get_it.dart';
import 'package:helpnest/features/auth/data/data_source/auth_remote_ds.dart';
import 'package:helpnest/features/auth/domain/repo/auth_repo.dart';
import 'package:helpnest/features/auth/presentation/cubit/auth_state.dart';
import 'package:helpnest/features/profile/data/data_source/profile_remote_ds.dart';
import 'package:helpnest/features/profile/domain/repo/profile_repo.dart';
import 'package:helpnest/features/profile/presentation/cubit/profile_state.dart';
import 'package:helpnest/features/service/data/data_source/service_remote_ds.dart';
import 'package:helpnest/features/service/domain/repo/service_repo.dart';
import 'package:helpnest/features/service/presentation/cubit/service_state.dart';

class Injections {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> init() async {
    // auth
    _getIt.registerFactory<AuthRepo>(() => AuthRemoteDs());
    _getIt.registerFactory<AuthCubit>(() => AuthCubit(repo: _getIt()));

    // profile
    _getIt.registerFactory<ProfileRepo>(() => ProfileRemoteDs());
    _getIt.registerFactory<ProfileCubit>(() => ProfileCubit(repo: _getIt()));

    // service
    _getIt.registerFactory<ServiceRepo>(() => ServiceRemoteDs());
    _getIt.registerFactory<ServiceCubit>(() => ServiceCubit(repo: _getIt()));  
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
