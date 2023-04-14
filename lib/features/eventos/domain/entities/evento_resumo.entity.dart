import 'package:floor/floor.dart';

@Entity()
class EventoResumo {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String nome;
  final DateTime dataHora;
  final String local;
  final String urlPoster;

  EventoResumo({
    required this.id,
    required this.nome,
    required this.dataHora,
    required this.local,
    required this.urlPoster,
  });
}
