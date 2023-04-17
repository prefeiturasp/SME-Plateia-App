import 'package:freezed_annotation/freezed_annotation.dart';

import 'arquivos.model.dart';
import 'evento_tipo.model.dart';

part 'evento.model.freezed.dart';
part 'evento.model.g.dart';

@freezed
class EventoModel with _$EventoModel {
  factory EventoModel({
    @JsonKey(name: 'name') required String nome,
    @JsonKey(name: 'synopsis', defaultValue: '') required String sinopse,
    @JsonKey(name: 'classification', defaultValue: 'Livre') required String classificacao,
    @JsonKey(name: 'duration', defaultValue: 0) required int duracao,
    @JsonKey(name: 'showtypeid') EventoTipoModel? tipo,
    @JsonKey(name: 'genreid') EventoTipoModel? genero,
    @JsonKey(name: 'files') required List<ArquivosModel> arquivos,
  }) = _EventoModel;
  factory EventoModel.fromJson(Map<String, dynamic> json) => _$EventoModelFromJson(json);
}
