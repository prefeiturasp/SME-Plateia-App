// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/interfaces/i_usecase.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/eventos/domain/repositories/i_evento_repository.dart';

@LazySingleton()
class ObterEventosUseCase implements IUseCase<List<EventoResumo>, Params> {
  final IEventoRepository repository;

  ObterEventosUseCase(
    this.repository,
  );

  @override
  Future<Either<Failure, List<EventoResumo>>> call(Params params) async {
    var result = await repository.obterEventos(
      nome: params.nome,
      periodo: params.periodo,
      local: params.local,
      pagina: params.pagina,
    );
    return result;
  }
}

class Params extends Equatable {
  final String nome;
  final EnumEventoPeriodo periodo;
  final String local;
  final int pagina;

  Params({
    this.nome = '',
    this.periodo = EnumEventoPeriodo.essaSemana,
    this.local = '',
    this.pagina = 1,
  });

  @override
  List<Object> get props => [nome, periodo, local, pagina];
}
