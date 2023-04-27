import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/domain/usecases/use_case.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_evento_detalhes_repository.dart';

@LazySingleton()
class ObterDetalheEventoUsecase extends UseCase<EventoDetalhes, Params> {
  final IEventoDetalhesRepository _eventoDetalhesRepository;

  ObterDetalheEventoUsecase(this._eventoDetalhesRepository);

  @override
  Future<Either<Failure, EventoDetalhes>> call(Params params) async {
    return await _eventoDetalhesRepository.obterDetalhes(params.eventoId);
  }
}

class Params extends Equatable {
  final int eventoId;

  Params({required this.eventoId});

  @override
  List<Object> get props => [];
}
