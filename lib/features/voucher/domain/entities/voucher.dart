import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Voucher extends Equatable {
  @primaryKey
  final String inscricao_id;
  final String nome;
  final String rf;
  final String evento;
  final String data;
  final String horario;
  final String local;
  final String endereco;
  final String categoria;
  final String ingressos_por_membro;
  final String qrcode;

  Voucher({
    required this.inscricao_id,
    required this.nome,
    required this.rf,
    required this.evento,
    required this.data,
    required this.horario,
    required this.local,
    required this.endereco,
    required this.categoria,
    required this.ingressos_por_membro,
    required this.qrcode,
  });

  @override
  List<Object?> get props =>
      [inscricao_id, nome, rf, evento, data, horario, local, endereco, categoria, ingressos_por_membro, qrcode];
}
