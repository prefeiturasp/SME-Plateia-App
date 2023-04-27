extension DateTimeExtension on int {
  String get toMMSS => '${(this ~/ 60).toString().padLeft(2, '0')}h e ${(this % 60).toString().padLeft(2, '0')}m';
}
