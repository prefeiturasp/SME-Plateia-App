import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/eventos/domain/entities/enums/evento_periodo.enum.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';

abstract class IEventoRepository {
  Future<Either<Failure, List<EventoResumo>>> obterEventos({
    String? nome,
    EnumEventoPeriodo? periodo,
    String? local,
    int? pagina,
  });
}
