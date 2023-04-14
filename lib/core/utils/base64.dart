import 'dart:convert';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';

@injectable
class Base64Utils {
  String removeBase64Header(String header, String encoded) {
    String base64String = encoded.replaceAll(RegExp(header), '');
    return base64String;
  }

  Uint8List getBinaryDataFromBase64(String encoded) {
    final Uint8List bytes = base64.decode(encoded);
    return bytes;
  }
}
