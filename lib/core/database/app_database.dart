import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../features/eventos/data/datasources/evento_local_dao.dart';
import '../../features/eventos/domain/entities/evento_resumo.entity.dart';

import 'converters/date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([
  DateTimeConverter,
])
@Database(
  version: 1,
  entities: [
    EventoResumo,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  EventoResumoDao get eventoResumoDao;
}
