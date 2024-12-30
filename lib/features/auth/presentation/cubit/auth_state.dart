import 'package:equatable/equatable.dart';
import 'package:helpnest/core/config/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpnest/features/auth/domain/repo/auth_repo.dart';

part 'auth_cubit.dart';

class AuthState extends Equatable {
  final StateError error;
  final StateStatus status;

  const AuthState({
    this.error = const StateError(),
    this.status = StateStatus.initial,
  });

  AuthState copyWith({
    StateError? error,
    StateStatus? status,
  }) {
    return AuthState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [error, status];
}
