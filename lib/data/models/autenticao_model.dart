import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

part 'autenticao_model.g.dart';

@JsonSerializable()
class AutenticacaoModel extends Autenticacao {
  AutenticacaoModel({
    required String token,
  }) : super(
          token: token,
        );

  factory AutenticacaoModel.fromJson(Map<String, dynamic> json) => _$AutenticacaoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AutenticacaoModelToJson(this);
}
