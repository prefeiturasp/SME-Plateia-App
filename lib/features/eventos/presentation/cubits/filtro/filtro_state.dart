part of 'filtro_cubit.dart';

enum EnumPageStatus {
  inicial,
  comResultado,
  semResultado,
  erro,
}

@freezed
class FiltroState with _$FiltroState {
  const factory FiltroState.initial({
    @Default('') String nomeEvento,
    @Default(EnumEventoPeriodo.proximosEventos) EnumEventoPeriodo periodoEvento,
    @Default('') String localEvento,
    @Default(EnumPageStatus.inicial) EnumPageStatus pageStatus,
    @Default([]) List<EventoResumo> resultado,
    @Default('') String resultadoNomeBusca,
    @Default(true) bool noMoreData,
    @Default('') String exceptionError,
  }) = _Initial;
}
