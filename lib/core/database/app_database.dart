import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'converters/date_time_converter.dart';

part 'app_database.g.dart';

@TypeConverters([
  DateTimeConverter,
])
@Database(
  version: 1,
  entities: [],
)
abstract class AppDatabase extends FloorDatabase {}
