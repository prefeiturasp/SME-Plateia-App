import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Voucher extends Equatable {
  @primaryKey
  final String inscricaoId;
  final String nome;
  final String rf;
  final String evento;
  final String data;
  final String horario;
  final String local;
  final String endereco;
  final String categoria;
  final String ingressosPorMembro;
  final String qrcode;

  Voucher({
    required this.inscricaoId,
    required this.nome,
    required this.rf,
    required this.evento,
    required this.data,
    required this.horario,
    required this.local,
    required this.endereco,
    required this.categoria,
    required this.ingressosPorMembro,
    required this.qrcode,
  });

  @override
  List<Object?> get props =>
      [inscricaoId, nome, rf, evento, data, horario, local, endereco, categoria, ingressosPorMembro, qrcode];
}
