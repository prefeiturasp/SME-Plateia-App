import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/database/app_database.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';

import 'evento_detalhes_dao.dart';

abstract class IEventoDetalhesLocalDataSource {
  Future<EventoDetalhes?> findById(int idEvento);

  Future<void> insertOrUpdateEntity(EventoDetalhes domain);
}

@LazySingleton(as: IEventoDetalhesLocalDataSource)
class EventoDetalhesLocalDataSource implements IEventoDetalhesLocalDataSource {
  late EventoDetalhesDao dao;

  EventoDetalhesLocalDataSource(AppDatabase appDatabase) {
    dao = appDatabase.eventoDetalhesDao;
  }

  @override
  Future<EventoDetalhes?> findById(int idEvento) {
    return dao.findById(idEvento);
  }

  @override
  Future<void> insertOrUpdateEntity(EventoDetalhes eventoDetalhes) {
    return dao.insertOrUpdateEntity(eventoDetalhes);
  }
}
