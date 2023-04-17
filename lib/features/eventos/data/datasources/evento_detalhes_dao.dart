import 'package:floor/floor.dart';
import 'package:sme_plateia/core/interfaces/i_crud.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';

@dao
abstract class EventoDetalhesDao extends ICrud<EventoDetalhes> {
  @Query('SELECT * FROM EventoDetalhes WHERE id = :id')
  Future<EventoDetalhes?> findById(int id);

  @Query('SELECT * FROM EventoDetalhes')
  Future<List<EventoDetalhes>> findAll();

  @Query('SELECT * FROM EventoDetalhes')
  Stream<List<EventoDetalhes>> findAllAsStream();

  @Query('DELETE FROM EventoDetalhes')
  Future<void> deleteAll();
}
