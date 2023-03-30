import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:template/core/domain/failures/failure.codegen.dart';
import 'package:template/features/auth/domain/entities/autenticacao.dart';
import 'package:template/features/auth/domain/repositories/i_authentication_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  final IAutenticacaoRepository _authenticationRepository;

  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthCubit(
    this._authenticationRepository,
  ) : super(const AuthState.initial()) {
    Future.delayed(Duration(seconds: 1), () {
      authCheckRequested();
    });

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => _onAuthenticationStatusChanged(status),
    );
  }

  void authCheckRequested() async {
    Either<Failure, Autenticacao?> result = await _authenticationRepository.getUsuarioAutenticado();

    result.fold(
      (l) => emit(AuthState.unauthenticated()),
      (r) {
        if (r != null) {
          emit(AuthState.authenticated());
        } else {
          emit(AuthState.unauthenticated());
        }
      },
    );
  }

  void logout() async {
    await _authenticationRepository.fazerLogout();
    emit(AuthState.unauthenticated());
  }

  Future<void> _onAuthenticationStatusChanged(AuthenticationStatus status) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(AuthState.authenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
