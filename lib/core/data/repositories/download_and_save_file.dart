import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/domain/repositories/i_download_and_save_file.dart';

@LazySingleton(as: IDownloadAndSaveFile)
class DownloadAndSaveFile implements IDownloadAndSaveFile {
  @override
  Future<dartz.Either<Failure, void>> openFile(File file) async {
    try {
      await OpenFile.open(file.path);
      return dartz.Right(null);
    } catch (e) {
      return dartz.Left(Failure.localFailure(message: e.toString()));
    }
  }

  @override
  Future<dartz.Either<Failure, File>> writeFile(
      String fileName, Uint8List bytesFile) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();

      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(bytesFile);

      return dartz.Right(file);
    } catch (e) {
      return dartz.Left(Failure.localFailure(message: e.toString()));
    }
  }
}
