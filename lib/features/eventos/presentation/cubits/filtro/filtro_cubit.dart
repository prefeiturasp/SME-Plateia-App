import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/domain/usecases/obter_eventos_usecase.dart';

part 'filtro_cubit.freezed.dart';
part 'filtro_state.dart';

@Singleton()
class FiltroCubit extends Cubit<FiltroState> {
  final ObterEventosUseCase obterEventosUseCase;
  int pageSize = 10;

  FiltroCubit(this.obterEventosUseCase) : super(FiltroState.initial());

  changeNomeEvento(String nomeEvento) {
    emit(state.copyWith(
      nomeEvento: nomeEvento,
    ));
  }

  changePeriodoEvento(EnumEventoPeriodo periodoEvento) {
    emit(state.copyWith(
      periodoEvento: periodoEvento,
    ));
  }

  changeLocalEvento(String localEvento) {
    emit(state.copyWith(
      localEvento: localEvento,
    ));
  }

  void requestMoreDate({
    required PagingController<int, EventoResumo> pagingController,
    int pageKey = 0,
    bool resetFilter = false,
  }) async {
    emit(state.copyWith(
      pageStatus: EnumPageStatus.inicial,
      resultadoNomeBusca: state.nomeEvento,
    ));

    if (resetFilter) {
      pagingController.refresh();
    }

    try {
      var result = await obterEventosUseCase.call(
        Params(
          nome: state.nomeEvento,
          periodo: state.periodoEvento,
          local: state.localEvento,
          pagina: pageKey,
        ),
      );

      result.fold(
        (l) => null,
        (newItems) {
          final isLastPage = newItems.length < pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(newItems, nextPageKey);
          }

          // Sem resultados para busca
          if (pagingController.value.itemList != null && pagingController.value.itemList!.isEmpty) {
            emit(state.copyWith(
              pageStatus: EnumPageStatus.semResultado,
              resultadoNomeBusca: state.nomeEvento,
            ));
          }
        },
      );
    } catch (error) {
      pagingController.error = error;
    }
  }
}
