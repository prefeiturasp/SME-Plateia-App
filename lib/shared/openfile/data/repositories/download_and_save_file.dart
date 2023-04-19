import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/shared/openfile/domain/repositories/i_download_and_save_file.dart';

@LazySingleton(as: IDownloadAndSaveFile)
class DownloadAndSaveFile implements IDownloadAndSaveFile {
  @override
  Future<dartz.Either<Failure, void>> openFile(File file) async {
    try {
      final openResult = await OpenFile.open(file.path);
      switch (openResult.type) {
        case ResultType.done:
          return dartz.Right(null);
        case ResultType.noAppToOpen:
          return dartz.Left(Failure.localFailure(
              message:
                  'Não foi possível exibir o arquivo. Verifique se há um aplicativo instalado em seu dispositivo capaz de abrir arquivos no formato PDF.'));
        case ResultType.fileNotFound:
          return dartz.Left(Failure.localFailure(message: 'Não foi possível encontrar o arquivo.'));
        case ResultType.permissionDenied:
          return dartz.Left(Failure.localFailure(
              message:
                  'Não foi possível acessar o arquivo. Verifique se você tem as permissões necessárias e tente novamente.'));
        case ResultType.error:
          return dartz.Left(Failure.localFailure(
              message:
                  'Ocorreu um erro ao tentar exibir o arquivo. Tente novamente mais tarde ou entre em contato com o suporte técnico.'));
      }
    } on Failure catch (e) {
      debugPrint(e.toString());
      return dartz.Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<dartz.Either<Failure, File>> writeFile(String fileName, Uint8List bytesFile) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytesFile);
      return dartz.Right(file);
    } on FileSystemException catch (e) {
      debugPrint(e.toString());
      return dartz.Left(Failure.localFailure(
          message: 'Ocorreu um erro ao tentar salvar o arquivo. Verifique as permissões necessárias.'));
    } on Failure catch (e) {
      debugPrint(e.toString());
      return dartz.Left(ServerFailure(
          message:
              'Ocorreu um erro ao tentar salvar o arquivo. Tente novamente mais tarde ou entre em contato com o suporte técnico.'));
    }
  }
}
