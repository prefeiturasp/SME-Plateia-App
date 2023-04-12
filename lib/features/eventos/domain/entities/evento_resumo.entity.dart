import 'package:freezed_annotation/freezed_annotation.dart';

part 'evento_resumo.entity.freezed.dart';

@freezed
abstract class EventoResumo with _$EventoResumo {
  factory EventoResumo({
    required String nome,
    required DateTime dataHora,
    required String local,
    required String urlPoster,
  }) = _EventoResumo;
}
