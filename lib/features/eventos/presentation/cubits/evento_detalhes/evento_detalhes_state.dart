part of 'evento_detalhes_cubit.dart';

@freezed
class EventoDetalhesState with _$EventoDetalhesState {
  const factory EventoDetalhesState.initial() = _Inicial;
  const factory EventoDetalhesState.loading() = _Loading;
  const factory EventoDetalhesState.loaded(EventoDetalhes eventoDetalhes) = _Loaded;
  const factory EventoDetalhesState.error(String mensagem) = _Error;
}
