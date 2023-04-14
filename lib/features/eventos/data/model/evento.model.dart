import 'package:freezed_annotation/freezed_annotation.dart';

import 'arquivos.model.dart';

part 'evento.model.freezed.dart';
part 'evento.model.g.dart';

@freezed
class EventoModel with _$EventoModel {
  factory EventoModel({
    @JsonKey(name: 'name') required String nome,
    @JsonKey(name: 'files') required List<ArquivosModel> arquivos,
  }) = _EventoModel;
  factory EventoModel.fromJson(Map<String, dynamic> json) => _$EventoModelFromJson(json);
}
