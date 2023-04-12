import 'package:injectable/injectable.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';

abstract class IEventoLocalDataSource {
  Future<void> saveAll(List<EventoResumo> entities);
  Future<List<EventoResumo>> getAll();
}

@Injectable(as: IEventoLocalDataSource)
class EventoLocalDataSource implements IEventoLocalDataSource {
  @override
  Future<List<EventoResumo>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> saveAll(List<EventoResumo> entities) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }
}
