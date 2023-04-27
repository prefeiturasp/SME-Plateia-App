import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';

import 'evento.model.dart';
import 'evento_cidade.model.dart';

part 'evento_detalhes.model.freezed.dart';
part 'evento_detalhes.model.g.dart';

@freezed
class EventoDetalhesModel with _$EventoDetalhesModel {
  const EventoDetalhesModel._();

  factory EventoDetalhesModel({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "local") required String local,
    @JsonKey(name: "address") required String endereco,
    @JsonKey(name: "schedule") required DateTime dataHoraProgramada,
    @JsonKey(name: "presentationdate") required DateTime dataHoraApresentacao,
    @JsonKey(name: "ticketbymember") required int numeroDeTicket,
    @JsonKey(name: "createdate") required DateTime createDate,
    @JsonKey(name: "updatedate") required DateTime updateDate,
    @JsonKey(name: "showid") required EventoModel evento,
    @JsonKey(name: "cityid") required EventoCidadeModel cidade,
    @JsonKey(name: "inscriptionid") required int inscricaoId,
    @JsonKey(name: "inscriptiondate") required DateTime inscricaoData,
  }) = _EventoDetalhesModel;
  factory EventoDetalhesModel.fromJson(Map<String, dynamic> json) => _$EventoDetalhesModelFromJson(json);

  EventoDetalhes toDomain() {
    String urlPoster = '';

    if (evento.arquivos.isNotEmpty) {
      urlPoster = evento.arquivos.first.path;
    }

    return EventoDetalhes(
        id: id,
        nome: evento.nome,
        dataHoraProgramada: dataHoraProgramada,
        dataHoraApresentacao: dataHoraApresentacao,
        local: local,
        urlPoster: urlPoster,
        endereco: endereco,
        numeroDeTicket: numeroDeTicket,
        cidade: cidade.nome,
        sinopse: evento.sinopse,
        classificacao: evento.classificacao,
        duracao: evento.duracao,
        tipo: evento.tipo?.nome ?? '',
        genero: evento.genero?.nome ?? '',
        createDate: createDate,
        updateDate: updateDate,
        inscricaoId: inscricaoId,
        inscricaoData: inscricaoData);
  }
}
