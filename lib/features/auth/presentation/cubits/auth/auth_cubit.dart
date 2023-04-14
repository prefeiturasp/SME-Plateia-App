import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/extensions/dartz_extensions.dart';
import 'package:sme_plateia/features/auth/domain/entities/autenticacao.dart';
import 'package:sme_plateia/features/auth/domain/repositories/i_authentication_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@singleton
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
      (falha) => emit(AuthState.unauthenticated()),
      (usuario) {
        if (usuario != null) {
          emit(AuthState.authenticated(usuario));
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
        var usuario = await _authenticationRepository.getUsuarioAutenticado();
        return emit(AuthState.authenticated(usuario.getRight()!));
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
