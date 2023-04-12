import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';

import 'evento.model.dart';
import 'evento_cidade.model.dart';

part 'evento_resumo.model.freezed.dart';
part 'evento_resumo.model.g.dart';

@freezed
class EventoResumoModel with _$EventoResumoModel {
  const EventoResumoModel._();

  factory EventoResumoModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "local") required String local,
    @JsonKey(name: "schedule") required DateTime dataHora,
    @JsonKey(name: "showid") required EventoModel evento,
    @JsonKey(name: "presentationdate") required DateTime dataApresentacao,
    @JsonKey(name: "cityid") required EventoCidadeModel cidade,
  }) = _EventoResumoModel;
  factory EventoResumoModel.fromJson(Map<String, dynamic> json) => _$EventoResumoModelFromJson(json);

  EventoResumo toDomain() {
    String? urlPoster;

    if (evento.arquivos.isNotEmpty) {
      urlPoster = evento.arquivos.first.path;
    } else {
      urlPoster = '';
    }

    return EventoResumo(
      id: id,
      dataHora: dataApresentacao,
      nome: evento.nome,
      local: local,
      urlPoster: urlPoster,
    );
  }
}
