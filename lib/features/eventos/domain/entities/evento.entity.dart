import 'package:freezed_annotation/freezed_annotation.dart';

part 'evento.entity.freezed.dart';

@freezed
abstract class EventoEntity with _$EventoEntity {
  factory EventoEntity() = _EventoEntity;
}
