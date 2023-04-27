import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/features/eventos/domain/usecases/obter_locais_eventos_usecase.dart';

part 'autocomplete_local_state.dart';
part 'autocomplete_local_cubit.freezed.dart';

@Singleton()
class AutocompleteLocalCubit extends Cubit<AutocompleteLocalState> {
  AutocompleteLocalCubit(this._obterLocaisEventosUsecase) : super(AutocompleteLocalState.initial());

  final ObterLocaisEventosUsecase _obterLocaisEventosUsecase;

  onChangeTermo(String termo) {
    emit(state.copyWith(
      termo: termo,
    ));
  }

  buscarLocal(String termo) async {
    if (termo.length < 3) {
      emit(state.copyWith(
        locais: [],
      ));
      return;
    }

    emit(state.copyWith(
      status: StatusAutoComplete.carregando,
      locais: [],
    ));

    var result = await _obterLocaisEventosUsecase(Params(termo: termo));

    result.fold(
      (l) => debugPrint(l.toString()),
      (r) {
        emit(state.copyWith(
          locais: r,
          status: StatusAutoComplete.resultado,
        ));
      },
    );
  }
}
