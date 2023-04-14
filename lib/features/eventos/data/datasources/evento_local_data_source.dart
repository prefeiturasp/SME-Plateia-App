import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/database/app_database.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';

abstract class IEventoLocalDataSource {
  Future<List<EventoResumo>> findAll();
  Future<void> saveAll(List<EventoResumo> entities);
  Future<void> deleteAll();
}

@Injectable(as: IEventoLocalDataSource)
class EventoLocalDataSource implements IEventoLocalDataSource {
  final AppDatabase appDatabase;

  EventoLocalDataSource(this.appDatabase);

  @override
  Future<List<EventoResumo>> findAll() async {
    var entities = await appDatabase.eventoResumoDao.findAll();
    return entities;
  }

  @override
  Future<void> saveAll(List<EventoResumo> entities) async {
    await appDatabase.eventoResumoDao.insertOrUpdateEntities(entities);
  }

  @override
  Future<void> deleteAll() async {
    await appDatabase.eventoResumoDao.deleteAll();
  }
}
