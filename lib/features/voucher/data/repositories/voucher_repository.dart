import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';

import 'package:sme_plateia/app/network/network_info.dart';
import 'package:sme_plateia/core/utils/base64.dart';
import 'package:sme_plateia/features/voucher/data/datasources/voucher_local_data_source.dart';
import 'package:sme_plateia/features/voucher/data/datasources/voucher_remote_data_source.dart';

import 'package:sme_plateia/features/voucher/data/models/voucher.model.dart';

import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/repositories/i_voucher_repository.dart';
import 'package:sme_plateia/shared/openfile/domain/usecases/download_and_save_file_usecase.dart';

@LazySingleton(as: IVoucherRepository)
class VoucherRepository implements IVoucherRepository {
  final IVoucherRemoteDataSource voucherRemoteDataSource;
  final IVoucherLocalDataSource voucherLocalDataSource;
  final INetworkInfo networkInfo;
  final Base64Utils base64Utils;
  final DownloadAndSaveFileUseCase downloadAndSaveFileUseCase;

  VoucherRepository(
    this.voucherRemoteDataSource,
    this.networkInfo,
    this.voucherLocalDataSource,
    this.base64Utils,
    this.downloadAndSaveFileUseCase,
  );

  @override
  Future<Either<Failure, Voucher>> getVoucherById(
    int inscricaoId,
  ) async {
    try {
      final result = await voucherRemoteDataSource.getVoucherById(id: inscricaoId);

      final VoucherModel voucherModel = result;

      await voucherLocalDataSource.insertOrUpdateEntity(voucherModel.toDomain());

      return Right(voucherModel.toDomain());
    } on Failure catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Voucher>> getLocalVoucherById(
    int inscricaoId,
  ) async {
    var voucherCache = await voucherLocalDataSource.findById(inscricaoId);

    if (voucherCache != null) {
      return Right(voucherCache);
    } else {
      return Left(Failure.localFailure(message: 'Cache não encontrado para o voucher ID $inscricaoId'));
    }
  }

  @override
  Future<Either<Failure, void>> openVoucherPDF(String base64PDF) async {
    String base64Formatted = base64Utils.removeBase64Header('data:application/pdf;base64,', base64PDF);
    Uint8List bytesFile = base64Utils.getBinaryDataFromBase64(base64Formatted);
    final resultBinaryData = await downloadAndSaveFileUseCase.writeFile('voucher.pdf', bytesFile);
    return resultBinaryData.fold((failure) => Left(failure), (file) async {
      final resultOpenFile = await downloadAndSaveFileUseCase.openFile(file);
      return resultOpenFile.fold((failure) => Left(failure), (void _) => Right(null));
    });
  }
}
