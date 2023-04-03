import 'package:equatable/equatable.dart';
import 'package:sme_plateia/features/auth/domain/entities/usuario.dart';

class Autenticacao extends Equatable {
  final String token;
  final String refreshToken;
  final Usuario usuario;

  Autenticacao({
    required this.refreshToken,
    required this.token,
    required this.usuario,
  });

  @override
  List<Object?> get props => [refreshToken, token, usuario];
}
