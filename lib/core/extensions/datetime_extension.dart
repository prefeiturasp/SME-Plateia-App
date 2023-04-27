import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatddMMyyy([String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat('dd/MM/yyyy', locale).format(this);
  }

  ///YYYY-MM-DD HH:MM
  String formatyyyyMMddHHmm([String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat('yyyy-MM-dd HH:mm', locale).format(this);
  }

  String formatHHmm([String? locale]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat('HH:mm', locale).format(this);
  }
}
