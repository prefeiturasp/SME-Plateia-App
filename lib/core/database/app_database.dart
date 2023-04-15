import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:sme_plateia/features/eventos/data/datasources/evento_detalhes_dao.dart';
import 'package:sme_plateia/features/eventos/data/datasources/evento_local_dao.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_detalhes.entity.dart';
import 'package:sme_plateia/features/eventos/domain/entities/evento_resumo.entity.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';

import 'converters/date_time_converter.dart';
import 'converters/list_string_converter.dart';

part 'app_database.g.dart';

@TypeConverters([
  DateTimeConverter,
  ListStringConverter,
])
@Database(
  version: 1,
  entities: [
    Voucher,
    VoucherFile,
    EventoResumo,
    EventoDetalhes,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  EventoResumoDao get eventoResumoDao;
  EventoDetalhesDao get eventoDetalhesDao;
}
