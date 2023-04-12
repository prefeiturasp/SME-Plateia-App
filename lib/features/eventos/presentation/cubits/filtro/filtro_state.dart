part of 'filtro_cubit.dart';

enum PageStatus {
  inicial,
  carregando,
  semEventos,
  comResultado,
  semResultado,
  erro,
}

@freezed
class FiltroState with _$FiltroState {
  const factory FiltroState.initial({
    @Default(EventoNome.pure()) EventoNome eventoNome,
    @Default(EventoPeriodo.pure()) EventoPeriodo eventoPeriodo,
    @Default(EventoLocal.pure()) EventoLocal eventoLocal,
    @Default(PageStatus.inicial) PageStatus pageStatus,
    @Default([]) List<EventoResumo> resultado,
    @Default('') String exceptionError,
  }) = _Initial;
}
