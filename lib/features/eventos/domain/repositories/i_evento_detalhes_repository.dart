import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';

abstract class IEventoDetalhesRepository {
  Future<Either<Failure, EventoDetalhes>> obterDetalhes(int eventoId);
}
