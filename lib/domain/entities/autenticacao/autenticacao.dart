import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'autenticacao.g.dart';

@JsonSerializable()
class Autenticacao extends Equatable {
  final String token;

  Autenticacao({
    required this.token,
  });

  factory Autenticacao.fromJson(Map<String, dynamic> json) => _$AutenticacaoFromJson(json);
  Map<String, dynamic> toJson() => _$AutenticacaoToJson(this);

  @override
  List<Object?> get props => [token];
}
