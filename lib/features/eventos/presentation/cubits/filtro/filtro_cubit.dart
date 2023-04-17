import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/domain/usecases/obter_eventos_usecase.dart';

part 'filtro_state.dart';
part 'filtro_cubit.freezed.dart';

@Singleton()
class FiltroCubit extends Cubit<FiltroState> {
  FiltroCubit(this.obterEventosUseCase) : super(FiltroState.initial());

  final ObterEventosUseCase obterEventosUseCase;
  int _page = 1;
  List<EventoResumo> _data = [];

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

  Future<void> carregarEventos({bool filtro = false}) async {
    emit(state.copyWith(
      pageStatus: EnumPageStatus.carregando,
    ));

    if (filtro) {
      _data = [];
      _page = 1;
    }

    var eventos = await obterEventosUseCase.call(
      Params(
        nome: state.nomeEvento,
        periodo: state.periodoEvento,
        local: state.localEvento,
        pagina: _page,
      ),
    );
    final noMoreData = eventos.length() < 20;
    _page++;

    eventos.fold(
      (erro) => debugPrint(erro.toString()),
      (result) {
        if (result.isEmpty) {
          emit(state.copyWith(
            pageStatus: EnumPageStatus.semResultado,
            resultadoNomeBusca: state.nomeEvento,
          ));
        } else {
          _data.addAll(result);

          emit(state.copyWith(
            pageStatus: EnumPageStatus.comResultado,
            resultado: _data,
            resultadoNomeBusca: state.nomeEvento,
            noMoreData: noMoreData,
          ));
        }
      },
    );
  }
}
