import 'package:equatable/equatable.dart';
import 'package:sme_plateia/features/auth/domain/entities/usuario.dart';

class Autenticacao extends Equatable {
  final String refresh;
  final String access;
  final Usuario usuario;

  Autenticacao({
    required this.refresh,
    required this.access,
    required this.usuario,
  });

  @override
  List<Object?> get props => [refresh, access, usuario];
}
