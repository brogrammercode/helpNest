import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';

abstract class SearchRemoteRepo {
  Stream<SearchParam> streamSearchResult({required String input});
  Future<SearchParam> getSearchResult({required String input});
}

class SearchParam {
  final List<UserModel> providers;
  final List<ServiceModel> services;

  SearchParam({required this.providers, required this.services});
}
