import 'dart:convert';
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
  // DownloadAndSaveFile();

  @override
  Future<Uint8List> getBinaryDataFromBase64(String encoded) async {
    final Uint8List bytes = base64.decode(encoded);
    return bytes;
  }

  @override
  Future<dartz.Either<Failure, void>> openFile(File file) async {
    try {
      await OpenFile.open(file.path);
      return dartz.Right(null);
    } catch (e) {
      return dartz.Left(e.toString());
    }
  }

  @override
  Future<dartz.Either<Failure, File>> writeFile(
      String fileName, Uint8List bytesFile) async {
    try {
      // Get the device's temporary directory
      final Directory tempDir = await getTemporaryDirectory();

      // Create a new file in the temporary directory
      final File file = File('${tempDir.path}/$fileName');

      // Write the bytes to the file
      await file.writeAsBytes(bytesFile);

      return dartz.Right(file);
    } catch (e) {
      return dartz.Left(e.toString());
    }
  }
}
