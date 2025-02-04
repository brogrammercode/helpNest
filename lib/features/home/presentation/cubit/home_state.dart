part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<AdBannerModel> adBanners;
  final Position? position;
  final StateStatus getAdBannerStatus;
  final StateStatus getPositionStatus;
  final CommonError error;

  const HomeState({
    this.adBanners = const [],
    this.position,
    this.getAdBannerStatus = StateStatus.initial,
    this.getPositionStatus = StateStatus.initial,
    this.error = const CommonError(),
  });

  HomeState copyWith({
    List<AdBannerModel>? adBanners,
    Position? position,
    StateStatus? getAdBannerStatus,
    StateStatus? getPositionStatus,
    CommonError? error,
  }) {
    return HomeState(
      adBanners: adBanners ?? this.adBanners,
      position: position ?? this.position,
      getAdBannerStatus: getAdBannerStatus ?? this.getAdBannerStatus,
      getPositionStatus: getPositionStatus ?? this.getPositionStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [adBanners, position, getAdBannerStatus, getPositionStatus, error];
}
