import 'package:sme_plateia/features/auth/data/models/usuario.model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/auth/domain/entities/autenticacao.dart';

part 'autenticacao.model.freezed.dart';
part 'autenticacao.model.g.dart';

@freezed
class AutenticacaoModel with _$AutenticacaoModel {
  const AutenticacaoModel._();

  factory AutenticacaoModel({
    @JsonKey(name: 'access') required String token,
    @JsonKey(name: 'refresh') required String refreshToken,
    @JsonKey(name: 'user') required UsuarioModel usuario,
  }) = _AutenticacaoModel;

  factory AutenticacaoModel.fromJson(Map<String, dynamic> json) => _$AutenticacaoModelFromJson(json);

  Autenticacao toDomain() {
    return Autenticacao(
      token: token,
      refreshToken: refreshToken,
      usuario: usuario.toDomain(),
    );
  }
}
