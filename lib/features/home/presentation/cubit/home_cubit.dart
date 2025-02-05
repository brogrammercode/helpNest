import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:helpnest/features/home/data/models/ad_banner_model.dart';
import 'package:helpnest/features/home/domain/repo/ad_banner_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AdBannerRepo _adBannerRepo;
  final StreamController<Position> _positionStreamController =
      StreamController<Position>();
  StreamSubscription<Position>? _positionSubscription;

  HomeCubit({required AdBannerRepo adBannerRepo})
      : _adBannerRepo = adBannerRepo,
        super(const HomeState()) {
    _initializePositionListener();
  }

  Future<void> updatePosition({required Position position}) async {
    emit(state.copyWith(position: position));
    _positionStreamController.add(position);
  }

  Future<void> getPosition() async {
    try {
      // Fetch the position here if necessary
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> getAdBanner({required Position? position}) async {
    try {
      emit(state.copyWith(getAdBannerStatus: StateStatus.loading));
      final adBanners = await _adBannerRepo.getAdBanner(position: position);
      emit(state.copyWith(
          adBanners: adBanners, getAdBannerStatus: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(
          getAdBannerStatus: StateStatus.failure,
          error: CommonError(consoleMessage: e.toString())));
    }
  }

  void _initializePositionListener() {
    _positionSubscription = _positionStreamController.stream.listen((position) {
      _onPositionChanged(position);
    });
  }

  void _onPositionChanged(Position? position) {
    getAdBanner(position: position);
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _positionStreamController.close();
    return super.close();
  }
}
