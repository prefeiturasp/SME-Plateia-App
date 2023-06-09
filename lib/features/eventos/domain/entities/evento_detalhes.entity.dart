// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity()
class EventoDetalhes extends Equatable {
  @PrimaryKey()
  final int id;
  final String nome;
  final DateTime dataHoraApresentacao;
  final DateTime dataHoraProgramada;
  final String local;
  final String urlPoster;

  final String endereco;

  final int numeroDeTicket;

  final String cidade;

  final String sinopse;
  final String classificacao;
  final int duracao;

  final String tipo;
  final String genero;

  final int inscricaoId;
  final DateTime inscricaoData;

  final DateTime createDate;
  final DateTime updateDate;

  EventoDetalhes({
    required this.id,
    required this.nome,
    required this.dataHoraApresentacao,
    required this.dataHoraProgramada,
    required this.local,
    required this.urlPoster,
    required this.endereco,
    required this.numeroDeTicket,
    required this.cidade,
    required this.sinopse,
    required this.classificacao,
    required this.duracao,
    required this.tipo,
    required this.genero,
    required this.createDate,
    required this.updateDate,
    required this.inscricaoId,
    required this.inscricaoData,
  });

  @override
  List<Object> get props => [];
}
