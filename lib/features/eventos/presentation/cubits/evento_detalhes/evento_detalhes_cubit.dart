import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';
import 'package:sme_plateia/features/eventos/domain/usecases/obter_detalhe_evento_usecase.dart';

part 'evento_detalhes_state.dart';
part 'evento_detalhes_cubit.freezed.dart';

@Singleton()
class EventoDetalhesCubit extends Cubit<EventoDetalhesState> {
  final ObterDetalheEventoUsecase _obterDetalheEventoUsecase;

  EventoDetalhesCubit(this._obterDetalheEventoUsecase) : super(EventoDetalhesState.initial());

  void carregarDetalhes(int eventoId) async {
    emit(EventoDetalhesState.loading());

    var result = await _obterDetalheEventoUsecase(Params(eventoId: eventoId));

    result.fold(
      (l) {
        debugPrint(l.toString());
        emit(EventoDetalhesState.error(l.toString()));
      },
      (r) {
        emit(EventoDetalhesState.loaded(r));
      },
    );
  }
}
