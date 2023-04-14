import 'package:floor/floor.dart';
import 'package:sme_plateia/core/interfaces/i_crud.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';

@dao
abstract class EventoResumoDao extends ICrud<EventoResumo> {
  @Query('SELECT * FROM EventoResumo WHERE id = :id')
  Future<EventoResumo?> findObjById(int id);

  @Query('SELECT * FROM EventoResumo')
  Future<List<EventoResumo>> findAll();

  @Query('SELECT * FROM EventoResumo')
  Stream<List<EventoResumo>> findAllAsStream();

  @Query('DELETE FROM EventoResumo')
  Future<void> deleteAll();
}
