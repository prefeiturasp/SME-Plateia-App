import 'package:freezed_annotation/freezed_annotation.dart';

part 'evento_tipo.model.freezed.dart';
part 'evento_tipo.model.g.dart';

@freezed
class EventoTipoModel with _$EventoTipoModel {
  factory EventoTipoModel({
    required int id,
    @JsonKey(name: 'name') required String nome,
  }) = _EventoTipoModel;
  factory EventoTipoModel.fromJson(Map<String, dynamic> json) => _$EventoTipoModelFromJson(json);
}
