import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

part 'autenticao_dto.g.dart';

@JsonSerializable()
class AutenticacaoDto extends Autenticacao {
  AutenticacaoDto({
    required String token,
  }) : super(
          token: token,
        );

  factory AutenticacaoDto.fromJson(Map<String, dynamic> json) => _$AutenticacaoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AutenticacaoDtoToJson(this);
}
