part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<AdBannerModel> adBanners;
  final Position? position;
  final List<UserLocationModel> lastLocation;
  final bool locationEnabled;
  final StateStatus getAdBannerStatus;
  final StateStatus getLocationStatus;
  final CommonError error;

  const HomeState({
    this.adBanners = const [],
    this.position,
    this.lastLocation = const [],
    this.locationEnabled = false,
    this.getAdBannerStatus = StateStatus.initial,
    this.getLocationStatus = StateStatus.initial,
    this.error = const CommonError(),
  });

  HomeState copyWith({
    List<AdBannerModel>? adBanners,
    Position? position,
    List<UserLocationModel>? lastLocation,
    bool? locationEnabled,
    StateStatus? getAdBannerStatus,
    StateStatus? getLocationStatus,
    CommonError? error,
  }) {
    return HomeState(
      adBanners: adBanners ?? this.adBanners,
      position: position ?? this.position,
      lastLocation: lastLocation ?? this.lastLocation,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      getAdBannerStatus: getAdBannerStatus ?? this.getAdBannerStatus,
      getLocationStatus: getLocationStatus ?? this.getLocationStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [
        adBanners,
        position,
        lastLocation,
        locationEnabled,
        getAdBannerStatus,
        getLocationStatus,
        error
      ];
}
