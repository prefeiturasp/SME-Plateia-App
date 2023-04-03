import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/auth/domain/entities/usuario.dart';

part 'usuario.model.freezed.dart';
part 'usuario.model.g.dart';

@freezed
class UsuarioModel with _$UsuarioModel {
  const UsuarioModel._();

  factory UsuarioModel({
    @JsonKey(name: 'name') required String nome,
    required String rf,
  }) = _UsuarioModel;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => _$UsuarioModelFromJson(json);

  Usuario toDomain() {
    return Usuario(
      nome: nome,
      rf: rf,
    );
  }
}
