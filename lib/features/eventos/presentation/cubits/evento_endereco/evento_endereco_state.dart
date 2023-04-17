part of 'evento_endereco_cubit.dart';

@freezed
class EventoEnderecoState with _$EventoEnderecoState {
  const factory EventoEnderecoState.initial() = _Initial;
  const factory EventoEnderecoState.loading() = _Loading;
  const factory EventoEnderecoState.loaded(LatLng location) = _Loaded;
}
