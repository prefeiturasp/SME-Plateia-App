part of 'autocomplete_local_cubit.dart';

enum StatusAutoComplete {
  inicial,
  carregando,
  resultado,
}

@freezed
class AutocompleteLocalState with _$AutocompleteLocalState {
  const factory AutocompleteLocalState.initial({
    @Default([]) List<String> locais,
    @Default('') String termo,
    @Default(StatusAutoComplete.inicial) StatusAutoComplete status,
  }) = _Initial;
}
