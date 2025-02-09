part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int bottomNavIndex;
  final List<AdBannerModel> adBanners;
  final Position? position;
  final List<UserLocationModel> lastLocation;
  final bool locationEnabled;
  final StateStatus getAdBannerStatus;
  final StateStatus getLocationStatus;
  final StateStatus getLocationFromDatabaseStatus;
  final StateStatus updateLocationToDatabaseStatus;
  final CommonError error;

  const HomeState({
    this.bottomNavIndex = 0,
    this.adBanners = const [],
    this.position,
    this.lastLocation = const [],
    this.locationEnabled = false,
    this.getAdBannerStatus = StateStatus.initial,
    this.getLocationStatus = StateStatus.initial,
    this.getLocationFromDatabaseStatus = StateStatus.initial,
    this.updateLocationToDatabaseStatus = StateStatus.initial,
    this.error = const CommonError(),
  });

  HomeState copyWith({
    int? bottomNavIndex,
    List<AdBannerModel>? adBanners,
    Position? position,
    List<UserLocationModel>? lastLocation,
    bool? locationEnabled,
    StateStatus? getAdBannerStatus,
    StateStatus? getLocationStatus,
    StateStatus? getLocationFromDatabaseStatus,
    StateStatus? updateLocationToDatabaseStatus,
    CommonError? error,
  }) {
    return HomeState(
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      adBanners: adBanners ?? this.adBanners,
      position: position ?? this.position,
      lastLocation: lastLocation ?? this.lastLocation,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      getAdBannerStatus: getAdBannerStatus ?? this.getAdBannerStatus,
      getLocationStatus: getLocationStatus ?? this.getLocationStatus,
      getLocationFromDatabaseStatus:
          getLocationFromDatabaseStatus ?? this.getLocationFromDatabaseStatus,
      updateLocationToDatabaseStatus:
          updateLocationToDatabaseStatus ?? this.updateLocationToDatabaseStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [
        bottomNavIndex,
        adBanners,
        position,
        lastLocation,
        locationEnabled,
        getAdBannerStatus,
        getLocationStatus,
        getLocationFromDatabaseStatus,
        updateLocationToDatabaseStatus,
        error
      ];
}
