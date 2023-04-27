import 'package:floor/floor.dart';

@Entity()
class EventoResumo {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String nome;
  final DateTime dataHoraProgramada;
  final DateTime dataHoraApresentacao;
  final String local;
  final String urlPoster;

  EventoResumo({
    required this.id,
    required this.nome,
    required this.dataHoraProgramada,
    required this.dataHoraApresentacao,
    required this.local,
    required this.urlPoster,
  });
}
