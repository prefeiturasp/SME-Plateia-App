import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_local.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_nome.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_periodo.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/domain/usecases/obter_eventos_usecase.dart';

part 'filtro_state.dart';
part 'filtro_cubit.freezed.dart';

@Singleton()
class FiltroCubit extends Cubit<FiltroState> {
  FiltroCubit(this.obterEventosUseCase) : super(FiltroState.initial()) {
    carregarEventos();
  }

  final ObterEventosUseCase obterEventosUseCase;

  nomEventoChanged(String value) {
    final eventoNome = EventoNome.dirty(value);
    emit(state.copyWith(
      eventoNome: eventoNome,
    ));
  }

  periodoChanged(String value) {
    final eventoPeriodo = EventoPeriodo.dirty(value);
    emit(state.copyWith(
      eventoPeriodo: eventoPeriodo,
    ));
  }

  localEventoChanged(String value) {
    final eventoLocal = EventoLocal.dirty(value);
    emit(state.copyWith(
      eventoLocal: eventoLocal,
    ));
  }

  filtrar() {}

  carregarEventos() {
    obterEventosUseCase.call(Params());
  }
}
