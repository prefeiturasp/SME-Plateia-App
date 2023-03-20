import 'dart:io';

String fixture(String nome) => File('test/fixtures/$nome').readAsStringSync();
