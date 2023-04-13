import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';

abstract class IDownloadAndSaveFile {
  Future<Either<Failure, File>> writeFile(String fileName, Uint8List bytesFile);
  Future<Either<Failure, void>> openFile(File file);
}
