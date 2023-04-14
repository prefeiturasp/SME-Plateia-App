import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/shared/openfile/domain/repositories/i_download_and_save_file.dart';

@Singleton()
class DownloadAndSaveFileUseCase {
  final IDownloadAndSaveFile _downloadAndSaveFile;

  DownloadAndSaveFileUseCase(this._downloadAndSaveFile);

  Future<Either<Failure, File>> writeFile(String fileName, Uint8List bytesFile) async {
    return await _downloadAndSaveFile.writeFile(fileName, bytesFile);
  }

  Future<Either<Failure, void>> openFile(File file) async {
    return await _downloadAndSaveFile.openFile(file);
  }
}
